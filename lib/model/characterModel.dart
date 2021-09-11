
// customContent 정보를 담을 List 생성
import 'package:adeline_app/model/customContent.dart';

class CharacterModel{
  String? nickName;
  var level;
  var job;
  List<CustomContent> customContentList = [];

  CharacterModel(this.nickName,this.level,this.job);
}
