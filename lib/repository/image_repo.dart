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
  Future<List<ImageModel>?> loadNetworkImage() async {
    try {
      final url = Uri.parse("https://coffee.alexflipnote.dev/random.json");
      final List<ImageModel> imageList = [];

      for (int i = 0; i < 10; i++) {
        // fetch 4 images to prevent user lag i.e pagination

        final response = await http.get(url);
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

  Future<String?> saveImageToLocal(String imageUrl) async {
    try {
      final localdirectory = await getTemporaryDirectory();
      SharedPreferences sp = await SharedPreferences.getInstance();
      final existingImagePaths = sp.getStringList(favoriteImagesListK) ?? [];

      final fileName = imageUrl.split('/').last; // Use the image name from URL
      final filePath = '${localdirectory.path}/$fileName';

      final response = await Dio().download(imageUrl, filePath);

      // Check if the download was successful
      if (response.statusCode == 200) {
        existingImagePaths.add(filePath);
        sp.setStringList(favoriteImagesListK, existingImagePaths);
        return filePath; // Return the local path of the saved image
      } else {
        log('Failed to download image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error saving image to local cache: $e');
      return null;
    }
  }

  Future<File?> getImageFromLocalCache(String filePath) async {
    try {
      // Check if the file exists in the local storage
      final file = File(filePath);
      if (await file.exists()) {
        return file; // Return the File object if it exists
      } else {
        log('Image not found in local cache.');
        return null;
      }
    } catch (e) {
      log('Error retrieving image from local cache: $e');
      return null;
    }
  }

  Future<List<String>?> getFavoriteImagePaths() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final paths = sp.getStringList(favoriteImagesListK);
    return paths;
  }
}
