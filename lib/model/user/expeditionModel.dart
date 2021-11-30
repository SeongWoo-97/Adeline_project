import 'package:hive/hive.dart';

part 'expeditionModel.g.dart';

@HiveType(typeId: 5)
class ExpeditionModel {
  @HiveField(1)
  bool islandCheck = false; // 모험섬
  @HiveField(2)
  bool chaosGateCheck = false; // 카오스게이트
  @HiveField(3)
  bool fieldBoosCheck = false; // 필드보스
  @HiveField(4)
  bool ghostShipCheck = false; // 유령선
  @HiveField(5)
  bool challengeAbyssCheck = false; // 도전어비스
  @HiveField(6)
  bool chaosLineCheck = false; // 혼돈의 사선
  @HiveField(7)
  bool likeAbilityCheck = false; // 호감도
  @HiveField(8)
  bool rehearsalCheck = false; // 리허설
  @HiveField(9)
  bool dejavuCheck = false; // 데자뷰
  @HiveField(10)
  DateTime recentInitDateTime = DateTime.now();
  @HiveField(11)
  DateTime nextWednesday = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);
}
