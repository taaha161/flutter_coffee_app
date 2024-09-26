import 'package:coffee_app_vgv/bloc/image_carousel_bloc/bloc/image_carousel_bloc.dart';
import 'package:coffee_app_vgv/utils/image_state_enums.dart';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ImageCarouselBloc>().add(ImageLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImageCarouselBloc, ImageCarouselState>(
        builder: (context, state) {
          return AppinioSwiper(
            cardCount: 10,
            onSwipeBegin: (previousIndex, targetIndex, activity) {
              if (activity.direction == AxisDirection.left) {
                context.read<ImageCarouselBloc>().add(ImageLoadEvent());
              }
            },
            cardBuilder: (BuildContext context, int index) {
              switch (state.imageState) {
                case ImageState.loading:
                  return const Center(child: CircularProgressIndicator());
                case ImageState.success:
                  return Card(
                    elevation: 4.0, // Adds a shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12.0), // Rounded corners
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), // Adds padding inside the card
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            //height: MediaQuery.of(context).size.height * 0.65,
                            state.image.imageUrl!,
                            fit: BoxFit
                                .cover, // Adjusts the image to cover the available space
                          ),
                        ],
                      ),
                    ),
                  );

                case ImageState.error:
                  return Text("An error occurred");
              }
            },
          );
        },
      ),
    );
  }
}
