import 'dart:developer';
import 'dart:io';

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
    context.read<ImageCarouselBloc>().add(LocalImagesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: coffeeColor,
      body: BlocBuilder<ImageCarouselBloc, ImageCarouselState>(
        builder: (context, state) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppinioSwiper(
                  allowUnlimitedUnSwipe: true,
                  loop: true,
                  backgroundCardCount: 1,
                  maxAngle: 5,
                  cardCount: state.favoriteImagesPaths.isEmpty
                      ? 1
                      : state.favoriteImagesPaths
                          .length, // checking if no saved image,
                  onSwipeBegin: (previousIndex, targetIndex, activity) {},
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

_cardWidget(ImageCarouselState state, int index, BuildContext context) {
  if (state.favoriteImagesPaths.isEmpty) {
    return Center(
      child: Text("No saved image found",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          )),
    );
  }
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
              child: Image.file(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 1,
                File(state.favoriteImagesPaths[index]),
                fit: BoxFit
                    .cover, // Adjusts the image to according to the available height
              ),
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: whiteColor,
              child: Center(
                child: Text(
                  "Favorite Polaroid",
                  style: TextStyle(color: coffeeColor),
                ),
              ),
            )
          ],
        ),
      );

    case ImageState.error:
      return Center(
        child: Text("No saved image found",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            )),
      );
  }
}