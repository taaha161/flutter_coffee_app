import 'dart:async';
import 'dart:io';

import 'package:coffee_app_vgv/models/image_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageRepository {
  Future<ImageModel?> loadNetworkImage() async {
    try {
      final url = Uri.parse("https://coffee.alexflipnote.dev/random.json");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // response OK

        final jsonObject = json.decode(response.body);
        return ImageModel.fromJson(jsonObject);
      }
      return null; // returns null i.e no image object if error
    } on SocketException {
      throw Exception("Error loading Image");
    } on TimeoutException {
      throw Exception("Error loading Image");
    }
  }
}
