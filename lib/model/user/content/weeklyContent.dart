import 'package:hive/hive.dart';

part 'weeklyContent.g.dart';

@HiveType(typeId: 4)
class WeeklyContent   {
  @HiveField(0)
  String name;
  @HiveField(1)
  String iconName;
  @HiveField(2)
  bool isChecked = true;
  @HiveField(3)
  bool view;

  WeeklyContent(this.name, this.iconName, this.view, {this.isChecked = false});
}
