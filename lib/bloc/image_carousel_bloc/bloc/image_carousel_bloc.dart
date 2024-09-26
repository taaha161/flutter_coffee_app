import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_carousel_event.dart';
part 'image_carousel_state.dart';

class ImageCarouselBloc extends Bloc<ImageCarouselEvent, ImageCarouselState> {
  ImageCarouselBloc() : super(ImageCarouselInitial()) {
    on<ImageCarouselEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
