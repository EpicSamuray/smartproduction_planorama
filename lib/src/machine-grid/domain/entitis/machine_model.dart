class Machine {
  final String id;
  final String name;
  final String category;
  final String location;
  final double capacity;
  final String? imageLocalPath;
  final String? imageId;

  Machine({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.capacity,
    this.imageLocalPath,
    this.imageId,
  });
}
