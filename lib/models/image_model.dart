class ImageModel {
  final String? imageUrl; // nullable because empty model until fetched from api
  final bool? isLiked;
  final String?
      localLocation; // For the location of local directory if image is liked

  const ImageModel({this.imageUrl, this.isLiked, this.localLocation});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageUrl: json["file"]);
  }
}
