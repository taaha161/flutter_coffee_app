import 'dart:developer';

import 'package:coffee_app_vgv/bloc/image_carousel_bloc/bloc/image_carousel_bloc.dart';
import 'package:coffee_app_vgv/utils/colors.dart';
import 'package:coffee_app_vgv/utils/image_state_enums.dart';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ImageCarouselBloc>().add(ImagesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: coffeeColor,
      body: BlocBuilder<ImageCarouselBloc, ImageCarouselState>(
        builder: (context, state) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppinioSwiper(
                  initialIndex: 0,
                  backgroundCardCount: 0,
                  maxAngle: 5,
                  cardCount: state.imageCount,
                  onSwipeBegin: (previousIndex, targetIndex, activity) {
                    if (targetIndex % 9 == 0) {
                      context
                          .read<ImageCarouselBloc>()
                          .add(NextImagesEvent()); // load more coffee
                    }
                  },
                  cardBuilder: (BuildContext context, int index) {
                    return _cardWidget(state, index, context);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

_cardWidget(state, index, context) {
  switch (state.imageState) {
    case ImageState.loading:
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: whiteColor,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Loading very good coffee!",
            style: TextStyle(color: whiteColor),
          )
        ],
      ));
    case ImageState.success:
      return Card(
        elevation: 4.0, // Adds a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        color: coffeeColor,

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Image.network(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 1,
                state.images[index].imageUrl!,
                fit: BoxFit
                    .cover, // Adjusts the image to according to the available height
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 149, 149, 149),
                    highlightColor: const Color.fromARGB(255, 0, 0, 0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: whiteColor,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Image failed to load',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

    case ImageState.error:
      return Center(
        child: Text(
            "An error occurred, please check your internet connection and try again",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )),
      );
  }
}
