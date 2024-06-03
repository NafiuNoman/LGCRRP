
class ImageInfoModel {
  final bool hasGeotag;
  final double latitude;
  final double longitude;
  final String imagePath;

  ImageInfoModel(
      {required this.hasGeotag,
      this.latitude = 0.0,
      this.longitude = 0.0,
      required this.imagePath});
}
