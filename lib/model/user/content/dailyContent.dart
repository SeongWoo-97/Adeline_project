// 사용자가 원하는 아이콘 디자인과 항목이름
// 컨텐츠 이름, 이미지 파일, View 여부(활성화 여부)
// 일단 이 클래스가 세부 컨텐츠
import 'package:hive/hive.dart';

part 'dailyContent.g.dart';

@HiveType(typeId: 3)
class DailyContent  {
  @HiveField(0)
  String name; // 작성한 항목이름
  @HiveField(1)
  String iconName; // 아이콘 위치이름
  @HiveField(2)
  bool isChecked = true;
  @HiveField(3)
  bool clearCheck = false;
  @HiveField(4)
  bool testBool = false;
  @HiveField(5)
  int gold = 0;

  DailyContent(this.name, this.iconName, this.isChecked);
}
// 일일컨텐츠 기준
// 사용자들은 컨텐츠가 표시되고, 숙제 체크여부 하고, 휴식게이지와 연결되고(이건 따로 연결해야할듯?)