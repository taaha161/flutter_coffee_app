import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:coffee_app_vgv/utils/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:coffee_app_vgv/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ImageRepository {
  Future<List<ImageModel>?> loadNetworkImage({http.Client? client}) async {
    try {
      final url = Uri.parse("https://coffee.alexflipnote.dev/random.json");
      final List<ImageModel> imageList = [];
      final httpClient = client ?? http.Client(); // for unit tests later

      for (int i = 0; i < 10; i++) {
        // fetch 10 images to prevent user lag i.e pagination

        final response = await httpClient.get(url);
        if (response.statusCode == 200) {
          // response OK
          final jsonObject = json.decode(response.body);
          imageList.add(ImageModel.fromJson(jsonObject));
        } else {
          return null;
        }
      }
      return imageList; // returns null i.e no image object if error
    } on SocketException {
      return null;
    } on TimeoutException {
      return null;
    }
  }

  Future<String?> saveImageToLocal(
    String imageUrl, {
    Dio? dio,
    SharedPreferences? sharedPreferences,
    Directory? localDirectory,
  }) async {
    try {
      final dioClient = dio ?? Dio(); // for unit tests later
      final sp = sharedPreferences ?? await SharedPreferences.getInstance();
      final directory = localDirectory ?? await getTemporaryDirectory();

      final existingImagePaths = sp.getStringList(favoriteImagesListK) ??
          []; // fetch existing paths to append into
      final fileName = imageUrl.split('/').last;
      final filePath = '${directory.path}/$fileName';

      final response = await dioClient.download(imageUrl, filePath);

      if (response.statusCode == 200) {
        existingImagePaths.add(filePath);
        await sp.setStringList(favoriteImagesListK,
            existingImagePaths); // add path to local storage
        return filePath;
      } else {
        log('Failed to download image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error saving image to local cache: $e');
      return null;
    }
  }

  Future<List<String>?> getFavoriteImagePaths(
      {SharedPreferences? perfs}) async {
    SharedPreferences sp = perfs ?? await SharedPreferences.getInstance();
    final paths =
        sp.getStringList(favoriteImagesListK); // get paths from local storage
    return paths;
  }
}
