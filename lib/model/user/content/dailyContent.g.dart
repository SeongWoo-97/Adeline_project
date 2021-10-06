// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyContent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyContentAdapter extends TypeAdapter<DailyContent> {
  @override
  final int typeId = 3;

  @override
  DailyContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyContent(
      fields[0] as String,
      fields[1] as String,
      fields[4] as bool,
      isChecked: fields[2] as bool,
    )..clearCheck = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, DailyContent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconName)
      ..writeByte(2)
      ..write(obj.isChecked)
      ..writeByte(3)
      ..write(obj.clearCheck)
      ..writeByte(4)
      ..write(obj.view);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
