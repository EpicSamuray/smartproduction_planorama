import 'package:appwrite/models.dart';

import '../../../../../common/toJson.abstract.dart';
class MachineCreatedDto extends JsonSerializable {
  final Future<Document> document;
  final Future<File> file;


  MachineCreatedDto({
    required this.document,
    required this.file,
  });

  factory MachineCreatedDto.fromJson(Map<String, dynamic> json) {
    return MachineCreatedDto(
      document: json['document']! as Future<Document>,
      file: json['file']! as Future<File>,
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