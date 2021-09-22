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
  String iconName;
  @HiveField(2)
  bool isChecked = true;
  @HiveField(3)
  bool view;

  DailyContent(this.name, this.iconName, this.view, {this.isChecked = false});
}
