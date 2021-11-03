// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characterModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 2;

  @override
  CharacterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterModel(
      fields[0] as int,
      fields[1] as String?,
      fields[2] as dynamic,
      fields[3] as dynamic,
      (fields[5] as List).cast<WeeklyContent>(),
    )..dailyContentList = (fields[4] as List).cast<dynamic>();
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nickName)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.job)
      ..writeByte(4)
      ..write(obj.dailyContentList)
      ..writeByte(5)
      ..write(obj.weeklyContentList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
