class ImageModel {
  final String? imageUrl;
  final bool? isLiked;

  const ImageModel({this.imageUrl, this.isLiked});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageUrl: json["file"]); // parsing API Structure
  }
}
