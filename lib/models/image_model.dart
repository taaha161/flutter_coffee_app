class ImageModel {
  final String? imageUrl; // nullable because empty model until fetched from api
  final bool? isLiked;

  const ImageModel({this.imageUrl, this.isLiked});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageUrl: json["file"]);
  }
}
