import 'dart:async';
import 'dart:io';

import 'package:coffee_app_vgv/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageRepository {
  Future<List<ImageModel>?> loadNetworkImage({bool initial = false}) async {
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
      throw Exception("Error loading Image");
    } on TimeoutException {
      throw Exception("Error loading Image");
    }
  }
}
