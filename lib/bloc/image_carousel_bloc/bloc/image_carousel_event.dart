part of 'image_carousel_bloc.dart';

sealed class ImageCarouselEvent extends Equatable {
  const ImageCarouselEvent();

  @override
  List<Object> get props => [];
}

class ImageLoadEvent extends ImageCarouselEvent {}

class ImageLikeEvent extends ImageCarouselEvent {}

class ImageDislikeEvent extends ImageCarouselEvent {}
