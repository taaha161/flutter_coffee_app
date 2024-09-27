part of 'image_carousel_bloc.dart';

sealed class ImageCarouselEvent extends Equatable {
  const ImageCarouselEvent();

  @override
  List<Object> get props => [];
}

class ImagesLoadEvent extends ImageCarouselEvent {}

class NextImagesEvent extends ImageCarouselEvent {}

class ImageLikeEvent extends ImageCarouselEvent {}

class ImageDislikeEvent extends ImageCarouselEvent {}
