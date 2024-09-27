part of 'image_carousel_bloc.dart';

class ImageCarouselState extends Equatable {
  final List<ImageModel> images; // images list object
  final List<String> favoriteImagesPaths; // paths to favorite images
  final ImageState imageState;
  final int imageCount;
  const ImageCarouselState(
      {this.images = const <ImageModel>[],
      this.imageState = ImageState.loading,
      this.favoriteImagesPaths = const [],
      this.imageCount = 10});

  ImageCarouselState copyWith(
      {List<ImageModel>? images,
      ImageState? imageState,
      int? imageCount,
      List<String>? favoriteImagesPaths}) {
    final newList = [...?images, ...this.images];
    return ImageCarouselState(
        images: images != [] ? newList : this.images,
        imageState: imageState ?? this.imageState,
        favoriteImagesPaths: favoriteImagesPaths ?? this.favoriteImagesPaths,
        imageCount: imageCount ?? this.imageCount);
  } // copyWith constructor to impletement state change

  @override
  List<Object> get props =>
      [images, imageState, imageCount, favoriteImagesPaths];
}
