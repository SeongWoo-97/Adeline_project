// 사용자가 원하는 아이콘 디자인과 항목이름
// 컨텐츠 이름, 이미지 파일, View 여부(활성화 여부)
// 일단 이 클래스가 세부 컨텐츠
import 'package:adeline_app/model/abstractContent.dart';

class DailyContent implements AbstractContent{
  String name; // 작성한 항목이름
  String iconName;
  bool isChecked = true;
  bool view;


  DailyContent(this.name,this.iconName,this.view,{this.isChecked = true});
}