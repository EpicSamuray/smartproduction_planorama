class Machine {
  final String id;
  final String name;
  final String category;
  final String location;
  final double capacity;
  String? imageLocalPath;
  String? imageId;

  Machine({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.capacity,
    this.imageLocalPath,
    this.imageId,
  });

  void updateImageInformation(String imageLocalPath, String imageId) {
    this.imageLocalPath = imageLocalPath;
    this.imageId = imageId;
  }
}
