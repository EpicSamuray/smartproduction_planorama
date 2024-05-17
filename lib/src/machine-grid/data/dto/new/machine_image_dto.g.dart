// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_image_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineImageDtoAdapter extends TypeAdapter<MachineImageDto> {
  @override
  final int typeId = 0;

  @override
  MachineImageDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MachineImageDto(
      imageId: fields[1] as String,
      imageLocalPath: fields[2] as String,
      machineId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MachineImageDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.machineId)
      ..writeByte(1)
      ..write(obj.imageId)
      ..writeByte(2)
      ..write(obj.imageLocalPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineImageDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
