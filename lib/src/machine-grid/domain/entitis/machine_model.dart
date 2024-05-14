class Machine {
  final String id;
  final String name;
  final String? imageLocalPath;
  final String? imageId;

  Machine({
    required this.id,
    required this.name,
    this.imageLocalPath,
    this.imageId,
  });
}