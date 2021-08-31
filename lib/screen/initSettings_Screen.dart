import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:web_scraper/web_scraper.dart';

class InitSettingsScreen extends StatefulWidget {
  @override
  _InitSettingsScreenState createState() => _InitSettingsScreenState();
}

class _InitSettingsScreenState extends State<InitSettingsScreen> {
  TextEditingController textEditingController = TextEditingController(text: '성우웅');
  final webScraper = WebScraper('https://lostark.game.onstove.com');
  int _currentStep = 0;
  var job, level;
  List<String> characters = [];
  late DragAndDropList charactersOrder = DragAndDropList(children: []);

  /// 공백제거, 특수문자 금지 또는 검색시 반환값을 보고 결과 여부 출력
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
            title: Text('초기설정'),

            /// 초기화면으로 넘어가게 할지 고려
            leading: _currentStep != 0
                ? IconButton(onPressed: () => cancel(), icon: Icon(Icons.arrow_back))
                : Container()),
        body: SafeArea(
          child: Stepper(
            type: StepperType.horizontal,
            physics: ScrollPhysics(),
            currentStep: _currentStep,
            onStepTapped: (step) => tapped(step),
            steps: <Step>[
              Step(
                title: Text('대표 캐릭터'),
                content: stepOne(),
                isActive: _currentStep >= 0,
                state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text('캐릭터 순서'),
                content: stepTwo(),
                isActive: _currentStep >= 0,
                state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text('화면 설정'),
                content: stepThree(),
                isActive: _currentStep >= 0,
                state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
            ],
            controlsBuilder: (BuildContext context,
                {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              return Container();
            },
          ),
        ));
  }

  /// 파일별로 단계페이지를 나누고 싶었지만 해당 build 에서 선언된 변수들이 결합되어 있기 때문에
  /// 나눌수가 없으며 이런 문제점 때문에 상태관리 패키지를 사용하는것 같음
  /// step 이 넘어갈수록 엄청 복잡해질꺼 같다.
  /// init 폴더에 init_constant 파일을 만들고 변수를 집어넣어야 할것같다.
  /// 중복가능성이 있는 변수명들은 init_job, init_level 이런식으로 변경해야 할것같다.
  /// 밑의 소스는 보류 (65~102줄)
  /// 리팩토링 과정중 stepper 위젯의 결합도가 높다고 판단하여 백업..
  Widget stepOne() {
    return Column(
      children: [
        Column(
          children: [
            Text('본 캐릭터의 닉네임을 입력해주시길 바랍니다.'),
            Text('대표 캐릭터는 메인화면 상단에 고정 됩니다.'),
          ],
        ),
        PlatformWidgetBuilder(
          cupertino: (_, child, __) => CupertinoTextField(
            textAlign: TextAlign.center,
            controller: textEditingController,
          ),
          material: (_, child, __) => TextField(
            textAlign: TextAlign.center,
            controller: textEditingController,
          ),
        ),
        PlatformElevatedButton(
          child: Text('캐릭터 정보확인'),
          onPressed: () {
            // AlertDialog 확인유무 체크후 캐릭터 불러온후 다음단계로 이동
            charInfoCheck(textEditingController.value.text);
          },
        )
      ],
    );
  }

  Widget stepTwo() {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: DragAndDropLists(
          children: [charactersOrder],
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          listPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          itemDivider: Divider(
            thickness: 1,
            height: 10,
            color: Colors.grey[350],
          ),
          itemDecorationWhileDragging: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          listInnerDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          lastItemTargetHeight: 8,
          addLastItemTargetHeightToTop: true,
          lastListTargetSize: 40,
          listDragHandle: DragHandle(
            verticalAlignment: DragHandleVerticalAlignment.top,
            child: Container(),
          ),
          itemDragHandle: DragHandle(
            child: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.menu,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget stepThree() {
    return Container();
  }

  // 캐릭터 정보확인
  charInfoCheck(String nickName) async {
    bool loadWebPage = await webScraper.loadWebPage('/Profile/Character/$nickName');
    if (loadWebPage & getCharStateCheck(nickName)) {
      job = webScraper.getElementAttribute(
          'div > main > div > div.profile-character-info > img', 'alt');
      level = webScraper.getElementTitle(
          'div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item');

      showPlatformDialog(
          context: context,
          builder: (BuildContext context) {
            return PlatformAlertDialog(
              title: Text('$nickName'),
              content: Column(
                children: [
                  Text('${job[0]} ${level[0].toString().replaceAll('달성 아이템 레벨', '')} '),
                ],
              ),
              actions: [
                PlatformDialogAction(
                  child: PlatformText('맞습니다'),
                  // 캐릭터 순서 페이지로 이동
                  onPressed: () {
                    Navigator.pop(context);
                    getCharList();
                    continued();
                  },
                ),
                PlatformDialogAction(
                  child: PlatformText('아닙니다'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    } else if (getCharStateCheck(nickName) == false) {
      showPlatformDialog(
          context: context,
          builder: (BuildContext context) {
            return PlatformAlertDialog(
              title: Text('오류'),
              content: Column(
                children: [
                  Text('존재하지 않는 닉네임입니다.'),
                ],
              ),
              actions: [
                PlatformDialogAction(
                  child: PlatformText('이전'),
                  // 캐릭터 순서 페이지로 이동
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    } else {
      // 인터넷 연결상태 또는 서버 점검 문구
      showPlatformDialog(
          context: context,
          builder: (BuildContext context) {
            return PlatformAlertDialog(
              title: Text('오류'),
              content: Column(
                children: [
                  Text('로스트아크 서버 점검 또는 네트워크 연결이 원활하지 않아 데이터를 불러올 수가 없습니다.'),
                ],
              ),
              actions: [
                PlatformDialogAction(
                  child: PlatformText('이전'),
                  // 캐릭터 순서 페이지로 이동
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
  }

  // 닉네임 존재여부 확인
  bool getCharStateCheck(String nickName) {
    bool state = webScraper
        .getElementTitle('div.profile-ingame > div.profile-attention')
        .toString()
        .contains('캐릭터 정보가 없습니다.');

    return state ? false : true;
  }

  // 캐릭터 List 가져오기
  getCharList() {
    characters =
        webScraper.getElementTitle('#expand-character-list > ul > li > span > button > span');
    charactersOrder = DragAndDropList(
        header: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    '캐릭터 순서 지정',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: List.generate(characters.length, (index) {
          return DragAndDropItem(
            child: ListTile(
              title: Text(characters[index],style: TextStyle(fontSize: 14),),
              trailing: IconButton(onPressed: (){
                print('누름');
                delCharInList(index);
              },icon: Icon(Icons.delete_forever),),
            ),
          );
        }));
  }
  // 캐릭터 삭제
  delCharInList(int index) {
    characters.removeAt(index);
    charactersOrder = DragAndDropList(
        header: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    '캐릭터 순서 지정',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: List.generate(characters.length, (index) {
          return DragAndDropItem(
            child: ListTile(
              title: Text(characters[index],style: TextStyle(fontSize: 14),),
              trailing: IconButton(onPressed: (){
                print('누름');
                delCharInList(index);
              },icon: Icon(Icons.delete_forever),),
            ),
          );
        }));
    setState(() {

    });
  }

 // 화면전환
  tapped(int step) {
    setState(() => _currentStep = step);
  }

 // 다음단계
  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

 // 이전단계
  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = charactersOrder.children.removeAt(oldItemIndex);
      charactersOrder.children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }
}
