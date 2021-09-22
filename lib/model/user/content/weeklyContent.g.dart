// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weeklyContent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyContentAdapter extends TypeAdapter<WeeklyContent> {
  @override
  final int typeId = 4;

  @override
  WeeklyContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyContent(
      fields[0] as String,
      fields[1] as String,
      fields[3] as bool,
      isChecked: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyContent obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconName)
      ..writeByte(2)
      ..write(obj.isChecked)
      ..writeByte(3)
      ..write(obj.view);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
