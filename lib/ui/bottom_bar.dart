import 'package:coffee_app_vgv/ui/favorite_screen.dart';
import 'package:coffee_app_vgv/ui/home_screen.dart';
import 'package:coffee_app_vgv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  final _pageController = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AnimatedNotchBottomBar(
            bottomBarWidth: 50,
            durationInMilliSeconds: 00,
            color: bgColor,
            notchBottomBarController: _controller,
            onTap: (int index) {
              _controller.jumpTo(index);
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn);
            },
            itemLabelStyle: TextStyle(color: whiteColor),
            kIconSize: 24,
            kBottomRadius: 28,
            bottomBarItems: const [
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.coffee,
                  color: Colors.white,
                ),
                activeItem: Icon(
                  Icons.coffee_sharp,
                  color: coffeeColor,
                ),
                itemLabel: 'Coffee',
              ),
              BottomBarItem(
                inActiveItem: Icon(
                  Icons.favorite,
                  color: whiteColor,
                ),
                activeItem: Icon(
                  Icons.favorite_sharp,
                  color: coffeeColor,
                ),
                itemLabel: 'Favorites',
              ),
            ]),
        backgroundColor: coffeeColor,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [HomeScreen(), FavoriteScreen()],
        ));
  }
}
