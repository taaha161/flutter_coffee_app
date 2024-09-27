// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:coffee_app_vgv/bloc/image_carousel_bloc/bloc/image_carousel_bloc.dart';
import 'package:coffee_app_vgv/ui/favorite_screen.dart';
import 'package:coffee_app_vgv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing  No Saved Image found', (WidgetTester tester) async {
    // Build the widget tree for the HomeScreen
    await tester.pumpWidget(BlocProvider(
      create: (context) => ImageCarouselBloc(),
      child: MaterialApp(
        title: 'Very Good Coffee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: bgColor),
          useMaterial3: true,
        ),
        home: const FavoriteScreen(),
      ),
    ));

    expect(find.text('No saved image found'), findsAtLeast(1));
  });
}
