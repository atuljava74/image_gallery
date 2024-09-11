import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class PixabayApiService {
  static const String apiKey = '45922670-e1e9f7ecead8743bdbbda35c4';
  static const String baseUrl = 'https://pixabay.com/api/';

  Future<List<ImageModel>> fetchImages(String query, int page) async {
    final response = await http.get(Uri.parse(
        '$baseUrl?key=$apiKey&q=$query&image_type=photo&page=$page&per_page=20'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['hits'] as List)
          .map((image) => ImageModel.fromJson(image))
          .toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
