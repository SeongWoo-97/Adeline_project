import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:adeline_app/model/user/expeditionModel.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:adeline_app/screen/MainMenu.dart';
import 'package:adeline_app/screen/contentSettings_screen.dart';
import 'package:adeline_app/screen/home_screen.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:drag_and_drop_lists/drag_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:web_scraper/web_scraper.dart';

import '../constant.dart';

class InitSettingsScreen extends StatefulWidget {
  @override
  _InitSettingsScreenState createState() => _InitSettingsScreenState();
}

class _InitSettingsScreenState extends State<InitSettingsScreen> {
  TextEditingController textEditingController = TextEditingController(text: '도기');
  final webScraper = WebScraper('https://lostark.game.onstove.com');
  int _currentStep = 0;
  late List<String?> job;
  late List<String?> level;
  bool loading = false;
  List<String> nickNameList = [];
  List<CharacterModel> characterModelList = [];
  late DragAndDropList charactersOrder = DragAndDropList(children: []);
  ExpeditionModel expeditionModel = ExpeditionModel();
  /// 공백제거, 특수문자 금지 또는 검색시 반환값을 보고 결과 여부 출력
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('초기설정'),
          leading: _currentStep != 0 ? IconButton(onPressed: () => cancel(), icon: Icon(Icons.arrow_back)) : Container(),
          trailingActions: [
            _currentStep == 1
                ? TextButton(
                child: Text('완료'),
                onPressed: () {
                  final box = Hive.box<User>('localDB');
                  DateTime now = DateTime.now();
                  DateTime nowDate = DateTime.utc(now.year, now.month, now.day, 6); // 오전6시를 고정시키기 위한 변수
                  if (expeditionModel.nextWednesday.weekday == 3) {
                    expeditionModel.nextWednesday = nowDate.add(Duration(days: 7));
                  } else {
                    while(expeditionModel.nextWednesday.weekday != 3){
                      nowDate = nowDate.add(Duration(days: 1));
                      expeditionModel.nextWednesday = nowDate;
                    }
                  }
                  box.put('user', User(characterList: characterModelList, expeditionModel: expeditionModel));
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainMenu()), (route) => false);
                })
                : Container()
          ],
          material: (_, __) =>
              MaterialAppBarData(
                backgroundColor: Colors.white,
                elevation: .5,
                title: Text(
                  '초기설정',
                  style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
        ),
        body: SafeArea(
          child: Container(
            child: Stepper(
              type: StepperType.vertical,
              physics: ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              steps: <Step>[
                Step(
                  title: Text('닉네임 입력', style: contentStyle),
                  content: stepOne(),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: Text('콘텐츠 설정', style: contentStyle),
                  content: stepTwo(),
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
                ),
              ],
              controlsBuilder: (BuildContext context, {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                return Container();
              },
            ),
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PlatformWidgetBuilder(
          cupertino: (_, child, __) =>
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: CupertinoTextField(
                  textAlign: TextAlign.center,
                  controller: textEditingController,
                ),
              ),
          material: (_, child, __) =>
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 35,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: textEditingController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: PlatformIconButton(
            icon: Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              charInfoCheck(textEditingController.value.text);
            },
          ),
        )
      ],
    );
  }

  Widget stepTwo() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: DragAndDropLists(
        children: [characterOrder()],
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        listPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        itemDecorationWhileDragging: BoxDecoration(
          color: Colors.transparent,
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
          color: Colors.transparent, // background 색
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
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.menu,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // 캐릭터 정보확인
  charInfoCheck(String nickName) async {
    showPlatformDialog(
      context: context,
      builder: (_) =>
          PlatformAlertDialog(
            material: (_, __) =>
                MaterialAlertDialogData(
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          '$nickName 정보 확인 중',
                          style: contentStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
            cupertino: (_, __) => CupertinoAlertDialogData(), // 기존소스 보고 수정하기
          ),
    );
    if (await webScraper.loadWebPage('/Profile/Character/$nickName') & !getCharStateCheck(nickName) & textEditingController.text
        .isNotEmpty) {
      Navigator.pop(context);
      job = webScraper.getElementAttribute('div > main > div > div.profile-character-info > img', 'alt');
      level = webScraper.getElementTitle('div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item');

      if(job.isNotEmpty && level.isNotEmpty) {
        showPlatformDialog(
          context: context,
          builder: (_) =>
              PlatformAlertDialog(
                material: (_, __) =>
                    MaterialAlertDialogData(
                      title: Text('$nickName', style: contentStyle),
                      content: Text(
                          'Lv.${levelText(level[0].toString())} ${job[0]} ', style: contentStyle.copyWith(color: Colors.grey)),
                    ),
                cupertino: (_, __) =>
                    CupertinoAlertDialogData(
                      title: Text('$nickName'),
                      content: Column(
                        children: [
                          Text('${job[0]} ${level[0].toString().replaceAll('달성 아이템 레벨', '')} '),
                        ],
                      ),
                    ),
                actions: [
                  PlatformDialogAction(
                    child: PlatformText('아닙니다', style: contentStyle.copyWith(fontWeight: FontWeight.normal)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  PlatformDialogAction(
                    // 캐릭터 순서 페이지로 이동
                    child: PlatformText('맞습니다', style: contentStyle.copyWith(fontWeight: FontWeight.normal)),
                    onPressed: () async {
                      Navigator.pop(context);
                      await getCharList();
                      continued();
                    },
                  ),
                ],
              ),
        );
      } else {
        showPlatformDialog(
            context: context,
            builder: (BuildContext context) {
              return PlatformAlertDialog(
                title: Text('서버점검'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('로스트아크 서버 점검중 입니다.'),
                  ],
                ),
                actions: [
                  PlatformDialogAction(
                    child: PlatformText('확인'),
                    // 캐릭터 순서 페이지로 이동
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            });
      }
    } else if (textEditingController.text.isEmpty) {
      showPlatformDialog(
          context: context,
          builder: (BuildContext context) {
            return PlatformAlertDialog(
              title: Text('오류'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('닉네임을 입력해 주시길 바랍니다.'),
                ],
              ),
              actions: [
                PlatformDialogAction(
                  child: PlatformText('확인'),
                  // 캐릭터 순서 페이지로 이동
                  onPressed: () {
                    Navigator.pop(context); // 오류창 닫기
                    Navigator.pop(context); // 정보확인중 창 닫기
                  },
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showPlatformDialog(
          context: context,
          builder: (BuildContext context) {
            return PlatformAlertDialog(
              title: Text('오류'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('로스트아크 서버 점검 또는 존재하지 않는 닉네임입니다.'),
                ],
              ),
              actions: [
                PlatformDialogAction(
                  child: PlatformText('확인'),
                  // 캐릭터 순서 페이지로 이동
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
    // else if (!getCharStateCheck(nickName) == false) {
    //   showPlatformDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return PlatformAlertDialog(
    //           title: Text('오류'),
    //           content: Column(
    //             children: [
    //               Text('존재하지 않는 닉네임입니다.'),
    //             ],
    //           ),
    //           actions: [
    //             PlatformDialogAction(
    //               child: PlatformText('이전'),
    //               // 캐릭터 순서 페이지로 이동
    //               onPressed: () => Navigator.pop(context),
    //             ),
    //           ],
    //         );
    //       });
    // }
  }

  // 닉네임 존재여부 확인
  bool getCharStateCheck(String nickName) {
    bool state = webScraper.getElementTitle('div.profile-ingame > div.profile-attention').toString().contains('캐릭터 정보가 없습니다.');
    // state 참 - 캐릭터가 존재하지 않음
    // state 거짓 - 캐릭터가 존재함
    return state ? true : false;
  }

  DragAndDropList characterOrder() {
    charactersOrder = DragAndDropList(
      children: List.generate(nickNameList.length, (index) {
        return DragAndDropItem(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(color: Colors.grey, width: 0.8),
            ),
            child: ListTile(
              title: Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Image.asset(
                        'assets/etc/Minus.png',
                        width: 25,
                        height: 25,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      showPlatformDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PlatformAlertDialog(
                            content: Text(
                              '${characterModelList[index].nickName} 캐릭터를 \n삭제하시겠습니까?',
                              style: contentStyle.copyWith(fontSize: 15),
                            ),
                            actions: [
                              PlatformDialogAction(
                                child: PlatformText('취소'),
                                // 캐릭터 순서 페이지로 이동
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              PlatformDialogAction(
                                child: PlatformText('삭제'),
                                // 캐릭터 순서 페이지로 이동
                                onPressed: () {
                                  nickNameList.removeAt(index);
                                  characterModelList.removeAt(index);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(characterModelList[index].nickName.toString(), style: contentStyle.copyWith(fontSize: 16)),
                      Text(
                        'Lv.${characterModelList[index].level} ${characterModelList[index].job}',
                        style: contentStyle.copyWith(fontSize: 14, color: Colors.black54),
                      )
                    ],
                  ),
                ],
              ),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              onTap: () async {
                characterModelList[index] = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ContentSettingsScreen(characterModelList[index])));
                setState(() {});
              },
            ),
          ),
        );
      }),
    );
    return charactersOrder;
  }

  ValueNotifier<String> getCharacterNickName = ValueNotifier<String>('');
  ValueNotifier<int> getCharacterNum = ValueNotifier<int>(0);

  // 캐릭터 List 가져오기
  getCharList() async {
    characterModelList.clear();
    nickNameList = webScraper.getElementTitle('#expand-character-list > ul > li > span > button > span');
    getCharacterNickName.value = nickNameList[0];
    getCharacterNum.value = 0;
    showPlatformDialog(
      context: context,
      builder: (_) =>
          PlatformAlertDialog(
            title: ValueListenableBuilder(
              valueListenable: getCharacterNum,
              builder: (BuildContext context, int num, Widget? child) {
                return Text('${num + 1}/${nickNameList.length}');
              },
            ),
            content: ValueListenableBuilder(
              valueListenable: getCharacterNickName,
              builder: (BuildContext context, String nickName, Widget? child) {
                return Text('$nickName \n캐릭터 불러오는 중');
              },
            ),
          ),
      barrierDismissible: false,
    );
    for (int i = 0; i < nickNameList.length; i++) {
      bool loadWebPage = await webScraper.loadWebPage('/Profile/Character/${nickNameList[i]}');
      if (loadWebPage) {
        String _nickName = nickNameList[i];
        getCharacterNickName.value = nickNameList[i];
        getCharacterNum.value = i;
        var _job = webScraper.getElementAttribute('div > main > div > div.profile-character-info > img', 'alt');
        var _level = levelText(
            webScraper.getElementTitle('div.profile-ingame > div.profile-info > div.level-info2 > div.level-info2__item')[0]);
        List<WeeklyContent> weeklyContentList = [];
        int itemLevel = int.parse(_level.toString());
        if (itemLevel >= 1325 && itemLevel < 1370) {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
            WeeklyContent('오레하의 우물', 'assets/week/AbyssDungeon.png', true),
          ];
        } else if (itemLevel >= 1370 && itemLevel < 1415) {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
            WeeklyContent('오레하의 우물', 'assets/week/AbyssDungeon.png', true),
            WeeklyContent('아르고스', 'assets/week/AbyssRaid.png', true),
          ];
        } else if (itemLevel >= 1415 && itemLevel < 1430) {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
            WeeklyContent('아르고스', 'assets/week/AbyssRaid.png', true),
            WeeklyContent('발탄', 'assets/week/Crops.png', true),
          ];
        } else if (itemLevel >= 1430 && itemLevel < 1475) {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
            WeeklyContent('아르고스', 'assets/week/AbyssRaid.png', true),
            WeeklyContent('발탄', 'assets/week/Crops.png', true),
            WeeklyContent('비아키스', 'assets/week/Crops.png', true),
          ];
        } else if (itemLevel >= 1475 && itemLevel < 1490) {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
            WeeklyContent('발탄', 'assets/week/Crops.png', true),
            WeeklyContent('비아키스', 'assets/week/Crops.png', true),
            WeeklyContent('쿠크세이튼', 'assets/week/Crops.png', true),
          ];
        } else if (itemLevel >= 1490) {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
            WeeklyContent('발탄', 'assets/week/Crops.png', true),
            WeeklyContent('비아키스', 'assets/week/Crops.png', true),
            WeeklyContent('쿠크세이튼', 'assets/week/Crops.png', true),
            WeeklyContent('아브렐슈드', 'assets/week/Crops.png', true),
          ];
        } else {
          weeklyContentList = [
            WeeklyContent('주간 에포나', 'assets/week/WeeklyEpona.png', false),
            WeeklyContent('실마엘 혈석 교환','assets/etc/GuildCoin.png',false),
            WeeklyContent('해적주화 교환','assets/etc/PirateCoin.png',false),
            WeeklyContent('도전가디언 토벌', 'assets/daily/Guardian.png', true),
          ];
        }
        CharacterModel characterModel = CharacterModel(_nickName, _level, _job[0], weeklyContentList);
        characterModelList.add(characterModel);
      }
      // else {
      //   // 점검또는 네트워크 또는 기타오류 출력 추가하기
      // }
    }
    characterModelList = List.from(characterModelList.reversed); // 캐릭터 순서 reversed
    Navigator.pop(context);
  }

  /// 캐릭터 삭제
  // delCharInList(int index) {
  //   characterModelList.removeAt(index);
  //   // print('del : ${characterModelList.length}');
  //   charactersOrder = DragAndDropList(
  //       children: List.generate(characterModelList.length, (index) {
  //     return DragAndDropItem(
  //       child: Card(
  //         child: ListTile(
  //           title: Text(characterModelList[index].nickName.toString(), style: TextStyle(fontSize: 16)),
  //           subtitle: Text('Lv.${characterModelList[index].level} ${characterModelList[index].job}'),
  //           trailing: IconButton(
  //             onPressed: () {
  //               setState(() {
  //                 delCharInList(index);
  //               });
  //             },
  //             icon: Icon(Icons.delete_forever),
  //           ),
  //           onTap: () async {
  //             // print(characterModelList[index].nickName);
  //             characterModelList[index] = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContentSettingsScreen(characterModelList[index])));
  //           },
  //         ),
  //       ),
  //     );
  //   }));
  // }

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

      var movedItem2 = characterModelList.removeAt(oldItemIndex);
      characterModelList.insert(newItemIndex, movedItem2);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }

  String levelText(String level) {
    int start = level.indexOf('.') + 1;
    int end = level.lastIndexOf('.');
    return level.substring(start, end).replaceAll(new RegExp(r'[^0-9]'), '');
  }
}
