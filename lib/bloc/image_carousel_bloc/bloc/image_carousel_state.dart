part of 'image_carousel_bloc.dart';

sealed class ImageCarouselState extends Equatable {
  const ImageCarouselState();
  
  @override
  List<Object> get props => [];
}

final class ImageCarouselInitial extends ImageCarouselState {}
