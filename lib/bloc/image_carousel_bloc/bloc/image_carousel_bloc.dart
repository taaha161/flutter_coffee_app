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
    on<ImageLoadEvent>((event, emit) async {
      await _fetchImage(event, emit);
    });
  }
  Future<void> _fetchImage(ImageCarouselEvent event, Emitter emit) async {
    try {
      final value = await imageRepo.loadNetworkImage();
      if (value != null) {
        emit(state.copyWith(
            image: value,
            imageState: ImageState.success)); // Successfully fetched url
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
}
