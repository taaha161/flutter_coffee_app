import 'package:coffee_app_vgv/bloc/image_carousel_bloc/bloc/image_carousel_bloc.dart';
import 'package:coffee_app_vgv/ui/onboarding_screen.dart';
import 'package:coffee_app_vgv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCarouselBloc(),
      child: MaterialApp(
        title: 'Very Good Coffee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: bgColor),
          useMaterial3: true,
        ),
        home: const OnboardingScreen(),
      ),
    );
  }
}
