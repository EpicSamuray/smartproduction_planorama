// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_image_location_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineImageLocationDtoAdapter
    extends TypeAdapter<MachineImageLocationDto> {
  @override
  final int typeId = 0;

  @override
  MachineImageLocationDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MachineImageLocationDto(
      imagesLocationPath: fields[0] as String,
      fileId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MachineImageLocationDto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imagesLocationPath)
      ..writeByte(1)
      ..write(obj.fileId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineImageLocationDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
