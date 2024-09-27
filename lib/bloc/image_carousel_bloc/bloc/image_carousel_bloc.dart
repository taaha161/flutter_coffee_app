import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:coffee_app_vgv/repository/image_repo.dart';
import 'package:coffee_app_vgv/models/image_model.dart';
import 'package:coffee_app_vgv/utils/image_state_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
  }
  Future<void> _fetchNetworkImage(
      ImageCarouselEvent event, Emitter emit) async {
    try {
      emit(state.copyWith(imageState: ImageState.loading));
      final value = await imageRepo.loadNetworkImage();
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
    emit(state.copyWith(imageState: ImageState.loading));
    await _fetchNetworkImage(event, emit);
  }

  Future<void> _fetchLocalImages(ImageCarouselEvent event, Emitter emit) async {
    emit(state.copyWith(imageState: ImageState.loading));
    final paths = await imageRepo.getFavoriteImagePaths();
    if (paths != null) {
      emit(state.copyWith(
          favoriteImagesPaths: paths, imageState: ImageState.success));
    } else {
      //No paths found hence error to be handled in UI
      emit(state.copyWith(imageState: ImageState.error));
    }
  }

  Future<void> _likeImage(ImageLikeEvent event, Emitter emit) async {
    final path = await imageRepo.saveImageToLocal(event.imageUrl);
    if (path != null) {
      List<String> newPaths = List.from(state.favoriteImagesPaths);
      newPaths.add(path);
      emit(state.copyWith(favoriteImagesPaths: newPaths));
    }
  }
}
