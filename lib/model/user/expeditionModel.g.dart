// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expeditionModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpeditionModelAdapter extends TypeAdapter<ExpeditionModel> {
  @override
  final int typeId = 5;

  @override
  ExpeditionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpeditionModel()
      ..islandCheck = fields[1] as bool
      ..chaosGateCheck = fields[2] as bool
      ..fieldBoosCheck = fields[3] as bool
      ..ghostShipCheck = fields[4] as bool
      ..challengeAbyssCheck = fields[5] as bool
      ..chaosLineCheck = fields[6] as bool
      ..likeAbilityCheck = fields[7] as bool
      ..rehearsalCheck = fields[8] as bool
      ..dejavuCheck = fields[9] as bool
      ..recentInitDateTime = fields[10] as DateTime
      ..nextWednesday = fields[11] as DateTime
      ..totalGold = fields[12] as int;
  }

  @override
  void write(BinaryWriter writer, ExpeditionModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.islandCheck)
      ..writeByte(2)
      ..write(obj.chaosGateCheck)
      ..writeByte(3)
      ..write(obj.fieldBoosCheck)
      ..writeByte(4)
      ..write(obj.ghostShipCheck)
      ..writeByte(5)
      ..write(obj.challengeAbyssCheck)
      ..writeByte(6)
      ..write(obj.chaosLineCheck)
      ..writeByte(7)
      ..write(obj.likeAbilityCheck)
      ..writeByte(8)
      ..write(obj.rehearsalCheck)
      ..writeByte(9)
      ..write(obj.dejavuCheck)
      ..writeByte(10)
      ..write(obj.recentInitDateTime)
      ..writeByte(11)
      ..write(obj.nextWednesday)
      ..writeByte(12)
      ..write(obj.totalGold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpeditionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
