import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../services/pixabay_api_service.dart';

class PixabayImageProvider with ChangeNotifier {
  final PixabayApiService _apiService = PixabayApiService();
  List<ImageModel> _images = [];
  bool _isLoading = false;
  int _currentPage = 1;
  String _query = 'nature'; // default query

  List<ImageModel> get images => _images;
  bool get isLoading => _isLoading;

  Future<void> fetchImages() async {
    _isLoading = true;
    notifyListeners();
    try {
      final newImages = await _apiService.fetchImages(_query, _currentPage);
      _images.addAll(newImages);
      _currentPage++;
    } catch (e) {
      print(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  PixabayImageProvider() {
    fetchImages();  // Fetch images on initialization with default query
  }

  void setQuery(String query) {
    _query = query;
    _images.clear();
    _currentPage = 1;
    fetchImages();
  }

  void loadMore() {
    if (!_isLoading) {
      fetchImages();
    }
  }
}
