import 'package:smartproduction_planorama/common/toJson.abstract.dart';

class MachineDTO implements JsonSerializable {
  final String machineId;
  final String name;
  final String category;
  final String location;
  final double capacity;

  MachineDTO({
    required this.machineId,
    required this.name,
    required this.category,
    required this.location,
    required this.capacity,
  });

  factory MachineDTO.fromJson(Map<String, dynamic> json) {
    return MachineDTO(
      machineId: json['\$id'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      capacity: json['capacity'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': machineId,
      'name': name,
      'category': category,
      'location': location,
      'capacity': capacity,
    };
  }
}
