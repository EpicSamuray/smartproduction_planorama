import 'package:smartproduction_planorama/common/toJson.abstract.dart';

class MachineDbUploadDto extends JsonSerializable {
  final String machineName;
  final String fileId;

  MachineDbUploadDto({
    required this.machineName,
    required this.fileId,
  });

  factory MachineDbUploadDto.fromJson(Map<String, dynamic> json) {
    return MachineDbUploadDto(
      fileId: json['fileId'],
      machineName: json['machineName'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fileId': fileId,
      'machineName': machineName,
    };
  }
}
