part of 'image_carousel_bloc.dart';

class ImageCarouselState extends Equatable {
  final ImageModel image; // image object
  final ImageState imageState;
  const ImageCarouselState(
      {this.image = const ImageModel(), this.imageState = ImageState.loading});

  ImageCarouselState copyWith({ImageModel? image, ImageState? imageState}) {
    return ImageCarouselState(
        image: image ?? this.image, imageState: imageState ?? this.imageState);
  } // copyWith constructor to impletement state change

  @override
  List<Object> get props => [image];
}
