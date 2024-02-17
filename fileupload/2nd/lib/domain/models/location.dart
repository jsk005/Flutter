class Location {
  final double latitude;
  final double longitude;
  bool? isLocation;

  Location({
    required this.latitude,
    required this.longitude,
    this.isLocation,
  });
}