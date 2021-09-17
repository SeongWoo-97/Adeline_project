// customContent 정보를 담을 List 생성
import 'package:adeline_app/model/dailyContent.dart';
import 'package:adeline_app/model/weeklyContent.dart';

class CharacterModel {
  String? nickName;
  var level;
  var job;
  List<DailyContent> dailyContentList = [
    DailyContent('카오스 던전', 'assets/daily/Chaos.png', false),
    DailyContent('가디언 토벌', 'assets/daily/Guardian.png', false),
    DailyContent('에포나 의뢰', 'assets/daily/Epona.png', false),
  ];
  List<WeeklyContent> weeklyContentList = [
    WeeklyContent('오레하의 우물', 'assets/week/AbyssDungeon.png', false),
    WeeklyContent('아르고스', 'assets/week/AbyssRaid.png', false),
    WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', false),
    WeeklyContent('발탄', 'assets/week/Crops.png', false),
    WeeklyContent('비아키스', 'assets/week/Crops.png', false),
    WeeklyContent('쿠크세이튼', 'assets/week/Crops.png', false),
    WeeklyContent('아브렐슈드', 'assets/week/Crops.png', false),
  ];

  CharacterModel(this.nickName, this.level, this.job);
}
