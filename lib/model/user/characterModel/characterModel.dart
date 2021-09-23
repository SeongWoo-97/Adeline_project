import 'package:adeline_app/model/user/content/dailyContent.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:hive/hive.dart';

part 'characterModel.g.dart';

@HiveType(typeId: 2)
class CharacterModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String? nickName;

  @HiveField(2)
  var level;

  @HiveField(3)
  var job;

  @HiveField(4)
  List<DailyContent> dailyContentList = [
    DailyContent('카오스 던전', 'assets/daily/Chaos.png', false),
    DailyContent('가디언 토벌', 'assets/daily/Guardian.png', false),
    DailyContent('에포나 의뢰', 'assets/daily/Epona.png', false),
  ];

  @HiveField(5)
  List<WeeklyContent> weeklyContentList = [
    WeeklyContent('오레하의 우물', 'assets/week/AbyssDungeon.png', false),
    WeeklyContent('아르고스', 'assets/week/AbyssRaid.png', false),
    WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', false),
    WeeklyContent('발탄', 'assets/week/Crops.png', false),
    WeeklyContent('비아키스', 'assets/week/Crops.png', false),
    WeeklyContent('쿠크세이튼', 'assets/week/Crops.png', false),
    WeeklyContent('아브렐슈드', 'assets/week/Crops.png', false),
  ];

  CharacterModel(this.id, this.nickName, this.level, this.job);
}