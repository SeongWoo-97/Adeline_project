// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restGaugeContent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestGaugeContentAdapter extends TypeAdapter<RestGaugeContent> {
  @override
  final int typeId = 6;

  @override
  RestGaugeContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestGaugeContent(
      fields[0] as String,
      fields[1] as String,
      fields[3] as int,
      fields[6] as bool,
    )
      ..clearNum = fields[2] as int
      ..restGauge = fields[4] as int
      ..lateRevision = fields[5] as DateTime
      ..clearCheck = fields[7] as bool
      ..saveRestGauge = fields[8] as int
      ..saveLateRevision = fields[9] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, RestGaugeContent obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconName)
      ..writeByte(2)
      ..write(obj.clearNum)
      ..writeByte(3)
      ..write(obj.maxClearNum)
      ..writeByte(4)
      ..write(obj.restGauge)
      ..writeByte(5)
      ..write(obj.lateRevision)
      ..writeByte(6)
      ..write(obj.isChecked)
      ..writeByte(7)
      ..write(obj.clearCheck)
      ..writeByte(8)
      ..write(obj.saveRestGauge)
      ..writeByte(9)
      ..write(obj.saveLateRevision);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestGaugeContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
