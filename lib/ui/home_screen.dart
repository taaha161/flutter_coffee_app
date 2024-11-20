import 'package:coffee_app_vgv/bloc/image_carousel_bloc/bloc/image_carousel_bloc.dart';
import 'package:coffee_app_vgv/utils/colors.dart';
import 'package:coffee_app_vgv/utils/image_state_enums.dart';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<ImageCarouselBloc>().add(NetworkImagesLoadEvent());
  }

  @override
  bool get wantKeepAlive => true; //  Prevents rebuild on page change

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  initialIndex: 0,
                  backgroundCardCount: 0,
                  maxAngle: 5,
                  cardCount: state.favoriteImagesPaths.isEmpty
                      ? 1
                      : state.favoriteImagesPaths.length,
                  onSwipeBegin: (previousIndex, targetIndex, activity) {
                    if (activity.direction == AxisDirection.up ||
                        activity.direction == AxisDirection.down) {
                      context.read<ImageCarouselBloc>().add(ImageLikeEvent(
                          imageUrl: state.images[previousIndex].imageUrl!));

                      Fluttertoast.showToast(msg: "Your image has been saved");
                    }
                    if (targetIndex % 9 == 0) {
                      context.read<ImageCarouselBloc>().add(
                          NextNetworkImagesEvent()); // load more coffee after the user has looked at 9 images
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

_cardWidget(ImageCarouselState state, int index, BuildContext context) {
  try {
    switch (state.imageState) {
      case ImageState.loading:
        return const Center(
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
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: whiteColor,
                child: const Center(
                  child: Text(
                    "Very Good Coffee Polaroid",
                    style: TextStyle(color: coffeeColor),
                  ),
                ),
              )
            ],
          ),
        );

      case ImageState.error:
        return const Center(
          child: Text(
              "An error occurred, please check your internet connection and try again",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              )),
        );
    }
  } catch (e) {
    if (state.images.isEmpty) {
      return const Center(
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
    }
  }
}
