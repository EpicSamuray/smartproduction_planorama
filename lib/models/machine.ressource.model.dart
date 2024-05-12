import '../common/toJson.abstract.dart';

class MachineRessourceDto implements JsonSerializable{
  String fileId;
  String machineName;

  MachineRessourceDto({
    required this.fileId,
    required this.machineName,
  });

  factory MachineRessourceDto.fromJson(Map<String, dynamic> json) {
    return MachineRessourceDto(
      fileId: json['fileId'],
      machineName: json['machineName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'machineName': machineName,
    };
  }
}