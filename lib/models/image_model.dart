class ImageModel {
  final String previewURL;
  final String webformatURL;
  final String largeImageURL;
  final int views;
  final int likes;

  ImageModel({
    required this.previewURL,
    required this.webformatURL,
    required this.largeImageURL,
    required this.views,
    required this.likes,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      previewURL: json['previewURL'] ?? '',
      webformatURL: json['webformatURL'] ?? '',
      largeImageURL: json['largeImageURL'] ?? '',
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
    );
  }
}
