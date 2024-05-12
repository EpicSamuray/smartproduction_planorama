// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine.card.dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MachineCardDtoAdapter extends TypeAdapter<MachineCardDto> {
  @override
  final int typeId = 0;

  @override
  MachineCardDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MachineCardDto(
      imagesLocationPath: fields[0] as String,
      machineName: fields[1] as String,
      imageId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MachineCardDto obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imagesLocationPath)
      ..writeByte(1)
      ..write(obj.machineName)
      ..writeByte(2)
      ..write(obj.imageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MachineCardDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
