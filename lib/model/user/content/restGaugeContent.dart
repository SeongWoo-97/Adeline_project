import 'package:hive/hive.dart';

part 'restGaugeContent.g.dart';

@HiveType(typeId: 6)
class RestGaugeContent {
  @HiveField(0)
  String name; // 컨텐츠 이름
  @HiveField(1)
  String iconName; // 아이콘 이름
  @HiveField(2)
  int clearNum = 0; // 클리어 횟수 [클리어 남은 횟수에 따라 휴식게이지 증가] // 2 또는 3
  @HiveField(3)
  int maxClearNum; // 최대 클리어 횟수
  @HiveField(4)
  int restGauge = 0; // 휴식 게이지
  @HiveField(5)
  DateTime lateRevision = DateTime.now(); // 최근 수정일
  @HiveField(6)
  bool isChecked = true; // 컨텐츠 사용여부
  @HiveField(7)
  bool clearCheck = false;

  int saveRestGauge = 0;

  RestGaugeContent(this.name, this.iconName, this.maxClearNum, this.isChecked);
}
