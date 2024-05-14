import 'package:appwrite/models.dart';

import '../../../../../common/toJson.abstract.dart';

class MachineCreatedDto extends JsonSerializable {
  final Document document;
  final File file;

  MachineCreatedDto({
    required this.document,
    required this.file,
  });

  factory MachineCreatedDto.fromJson(Map<String, dynamic> json) {
    return MachineCreatedDto(
      document: json['document'],
      file: json['file'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'document': document,
      'file': file,
    };
  }
}
