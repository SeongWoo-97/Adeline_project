// customContent 정보를 담을 List 생성
import 'package:adeline_app/model/dailyContent.dart';
import 'package:adeline_app/model/weeklyContent.dart';

class CharacterModel {
  String? nickName;
  var level;
  var job;
  List<DailyContent> dailyContentList = [
    DailyContent('카오스 던전', 'assets/daily/Chaos.png', true),
    DailyContent('가디언 토벌', 'assets/daily/Guardian.png', true),
    DailyContent('에포나 의뢰', 'assets/daily/Epona.png', true),
  ];
  List<WeeklyContent> weeklyContentList = [
    WeeklyContent(name: '오레하의 우물', iconName: 'assets/week/AbyssDungeon.png'),
    WeeklyContent(name: '아르고스', iconName: 'assets/week/AbyssRaid.png'),
    WeeklyContent(name: '도전가디언 토벌', iconName: 'assets/daily/Guardian.png'),
    WeeklyContent(name: '발탄', iconName: 'assets/week/Crops.png'),
    WeeklyContent(name: '비아키스', iconName: 'assets/week/Crops.png'),
    WeeklyContent(name: '쿠크세이튼', iconName: 'assets/week/Crops.png'),
    WeeklyContent(name: '아브렐슈드', iconName: 'assets/week/Crops.png'),
  ];

  CharacterModel(this.nickName, this.level, this.job);
}
