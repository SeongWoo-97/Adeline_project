import 'package:hive/hive.dart';

part 'expeditionModel.g.dart';

@HiveType(typeId: 5)
class ExpeditionModel {
  @HiveField(1)
  bool islandCheck = false;
  @HiveField(2)
  bool chaosGateCheck = false;
  @HiveField(3)
  bool fieldBoosCheck = false;
  @HiveField(4)
  bool ghostShipCheck = false;
  @HiveField(5)
  bool challengeAbyssCheck = false;
  @HiveField(6)
  bool chaosLineCheck = false;
  @HiveField(7)
  bool likeAbilityCheck = false;
  @HiveField(8)
  bool rehearsalCheck = false;
  @HiveField(9)
  bool dejavuCheck = false;
  @HiveField(10)
  DateTime recentInitDateTime = DateTime.now();
  @HiveField(11)
  DateTime nextWednesday = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);
}
