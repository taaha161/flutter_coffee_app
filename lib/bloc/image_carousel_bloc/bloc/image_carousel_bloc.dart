import 'package:bloc/bloc.dart';
import 'package:coffee_app_vgv/repository/image_repo.dart';
import 'package:coffee_app_vgv/models/image_model.dart';
import 'package:coffee_app_vgv/utils/image_state_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'image_carousel_event.dart';
part 'image_carousel_state.dart';

class ImageCarouselBloc extends Bloc<ImageCarouselEvent, ImageCarouselState> {
  final imageRepo = ImageRepository();
  ImageCarouselBloc() : super(const ImageCarouselState()) {
    on<NetworkImagesLoadEvent>((event, emit) async {
      await _fetchNetworkImage(event, emit);
    });
    on<NextNetworkImagesEvent>((event, emit) async {
      await _fetchNextNetworkImage(event, emit);
    });
    on<LocalImagesLoadEvent>((event, emit) async {
      await _fetchLocalImages(event, emit);
    });
    on<ImageLikeEvent>((event, emit) async {
      await _likeImage(event, emit);
    });
    on<ImageDisLikeEvent>((event, emit) async {
      await _disLikeImage(event, emit);
    });
  }
  Future<void> _fetchNetworkImage(
      ImageCarouselEvent event, Emitter emit) async {
    try {
      emit(state.copyWith(imageState: ImageState.loading)); // start by loading
      final value = await imageRepo.loadNetworkImage(); // fetch 10 more images
      if (value != null) {
        emit(state.copyWith(
            images: value,
            imageState: ImageState.success,
            imageCount: state.imageCount + 10)); // Successfully fetched url
      } else {
        emit(state.copyWith(
            imageState: ImageState.error)); // failed to fetch url
      }
    } catch (e) {
      emit(state.copyWith(
          imageState:
              ImageState.error)); // Something went wrong trying to fetch url
    }
  }

  Future<void> _fetchNextNetworkImage(
      ImageCarouselEvent event, Emitter emit) async {
    emit(state.copyWith(
        imageState: ImageState.loading)); // start by changing state to loading
    await _fetchNetworkImage(event, emit); // load more images
  }

  Future<void> _fetchLocalImages(ImageCarouselEvent event, Emitter emit) async {
    emit(state.copyWith(
        imageState: ImageState.loading)); // start by changing state to loading
    final paths = await imageRepo.getFavoriteImagePaths(); // Get local paths
    if (paths != null) {
      emit(state.copyWith(
          favoriteImagesPaths: paths,
          imageState: ImageState
              .success)); // if paths available change state to success and show paths
    }
  }

  Future<void> _likeImage(ImageLikeEvent event, Emitter emit) async {
    final path = await imageRepo.saveImageToLocal(
        event.imageUrl); //save image locally using the imageUrl as the path

    if (path != null) {
      List<String> newPaths = List.from(state
          .favoriteImagesPaths); // if saving path is successful add is it to the current list of paths
      newPaths.add(path);
      emit(state.copyWith(favoriteImagesPaths: newPaths));
    }
  }

  Future<void> _disLikeImage(ImageDisLikeEvent event, Emitter emit) async {
    final paths = await imageRepo
        .dislikeImage(event.imageUrl); //remove image from local storage

    List<String> newPaths = List.from(state.favoriteImagesPaths);
    newPaths.remove(event.imageUrl); // remove image from current paths
    emit(state.copyWith(favoriteImagesPaths: newPaths));
  }
}
