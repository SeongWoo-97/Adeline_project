import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:adeline_app/model/user/content/dailyContent.dart';
import 'package:adeline_app/model/user/content/restGaugeContent.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:adeline_app/model/user/expeditionModel.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:adeline_app/screen/initSettings_Screen.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

import '../constant.dart';
import 'OrderAndDelete_Screen.dart';
import 'addCharacter_Screen.dart';
import 'contentSettings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CharacterModel> list;
  late List<CharacterModel> changeList;
  late ExpeditionModel expeditionModel;
  final box = Hive.box<User>('localDB');
  bool blankCheckbox = true;
  bool dailyTitleColor = true;
  bool weeklyTitleColor = true;
  bool disableChaosGate = false;
  bool disableFieldBoss = false;
  bool disableGhostShip = false;
  CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();
  List<Widget> listCard = [];
  late DragAndDropList charactersOrder = DragAndDropList(children: []);
  List<BannerAd> bannerAdList = [];


  @override
  void initState() {
    super.initState();
    list = Hive.box<User>('localDB').get('user')!.characterList;
    changeList = list;
    // 휴식게이지 로직 //
    for (int i = 0; i < list.length; i++) {
      list[i].bannerAd.load();
      for (int j = 0; j < list[i].dailyContentList.length; j++) {
        if (list[i].dailyContentList[j] is RestGaugeContent) {
          // list[i].dailyContentList[j].saveRestGauge = 0;
          DateTime now = DateTime.now();
          DateTime lateRevision = list[i].dailyContentList[j].lateRevision;
          int clearNum = list[i].dailyContentList[j].clearNum;
          int maxClearNum = list[i].dailyContentList[j].maxClearNum;

          /// 현재시간과 최근수정일에 일수 차이가 0 일때
          if (list[i].dailyContentList[j].restGauge >= 100) {
            // print('${list[i].nickName} : 휴식게이지 100 이상');
            list[i].dailyContentList[j].restGauge = 100;
          } else if (now.difference(lateRevision).inDays == 0) {
            /// 기존 휴식게이지 출력
            if (now.hour < 6) {
              // print('${list[i].nickName} : inDays == 0, 오전6시 전');
              list[i].dailyContentList[j].restGauge = list[i].dailyContentList[j].restGauge;
            } else if (now.hour >= 6) {
              // print('${list[i].nickName} : inDays == 0, 오전6시 후');
              list[i].dailyContentList[j].restGauge = (maxClearNum - clearNum) * 10;
              list[i].dailyContentList[j].clearNum = 0;
              list[i].dailyContentList[j].saveRestGauge = 0;
            }
          } else if (now.difference(lateRevision).inDays == 1) {
            /// 현재시간과 최근수정일이 1일 차이 일때
            if (now.hour < 6) {
              /// 오전 6시 전 이면 기존 휴식게이지 출력
              // print('${list[i].nickName} : inDays == 1, 오전6시 전');
              list[i].dailyContentList[j].restGauge = list[i].dailyContentList[j].restGauge;
              list[i].dailyContentList[j].clearNum = 0;
              list[i].dailyContentList[j].saveRestGauge = 0;
            } else if (now.hour >= 6) {
              /// 오전 6시 후 면 전날 남은횟수 * 10 해서 휴식게이지 출력
              // print('${list[i].nickName} : inDays == 1, 오전6시 후');
              list[i].dailyContentList[j].restGauge = (maxClearNum - clearNum) * 10;
              list[i].dailyContentList[j].clearNum = 0;
              list[i].dailyContentList[j].saveRestGauge = 0;
            }
          } else if (now.difference(lateRevision).inDays > 1) {
            /// 현재시간과 최근수정일이 이틀 이상 일때
            if (now.hour < 6) {
              // print('${list[i].nickName} : inDays > 1, 오전6시 전');
              int a = DateTime.utc(now.year, now.month, now.day)
                      .difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1))
                      .inDays -
                  1;
              list[i].dailyContentList[j].restGauge = ((maxClearNum - clearNum) * 10) + (a * maxClearNum * 10);
              list[i].dailyContentList[j].clearNum = 0;
              list[i].dailyContentList[j].saveRestGauge = 0;
            } else if (now.hour >= 6) {
              // print('${list[i].nickName} : inDays > 1, 오전6시 후');
              int a = DateTime.utc(now.year, now.month, now.day)
                  .difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1))
                  .inDays;
              // print('a : $a');
              list[i].dailyContentList[j].restGauge = ((maxClearNum - clearNum) * 10) + (a * maxClearNum * 10);
              if (list[i].dailyContentList[j].restGauge >= 100) {
                list[i].dailyContentList[j].restGauge = 100;
              }
              list[i].dailyContentList[j].clearNum = 0;
              list[i].dailyContentList[j].saveRestGauge = 0;
            }
          }
        }
      }
    }
    // 휴식게이지 로직 //
    expeditionModel = Hive.box<User>('localDB').get('user')!.expeditionModel!;
    DateTime nowDate = DateTime.now(); // 현재날짜 오전6시 기준
    // 일일콘텐츠 초기화 로직 //
    if (expeditionModel.recentInitDateTime.day != nowDate.day && nowDate.hour >= 6) {
      expeditionModel.recentInitDateTime = DateTime.now(); // 최근초기화시간 최신화
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i].dailyContentList.length; j++) {
          if (list[i].dailyContentList[j] is DailyContent) {
            list[i].dailyContentList[j].clearCheck = false;
          }
        }
      }
    }
    // 주간콘텐츠 초기화 로직 //
    if (expeditionModel.recentInitDateTime.weekday == 3 && nowDate.hour >= 6) {
      if (expeditionModel.initCheck == false) {
        expeditionModel.initCheck = true;
        for (int i = 0; i < list.length; i++) {
          for (int j = 0; j < list[i].weeklyContentList.length; j++) {
            list[i].weeklyContentList[j].clearCheck = false;
          }
        }
      }
    } else {
      expeditionModel.initCheck = false;
    }
    // 저장
    box.put('user', User(characterList: list, expeditionModel: expeditionModel));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Adeline Project', style: contentStyle.copyWith(fontSize: 15, color: Colors.black)),
        material: (_, __) => MaterialAppBarData(
          backgroundColor: Colors.white,
          elevation: .5,
          title: Text(
            'Adeline Project',
            style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        trailingActions: [
          CustomPopupMenu(
            controller: _customPopupMenuController,
            pressType: PressType.singleClick,
            verticalMargin: -10,
            child: Container(
              child: Icon(Icons.menu, color: Colors.grey),
              padding: EdgeInsets.only(right: 10),
            ),
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '전체 초기화',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _customPopupMenuController.hideMenu();
                          showPlatformDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PlatformAlertDialog(
                                content: Text(
                                  '캐릭터마다 설정했던 모든 정보가 사라집니다. \n초기화하시겠습니까?',
                                  style: contentStyle.copyWith(fontSize: 14),
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
                                    child: PlatformText('초기화'),
                                    // 캐릭터 순서 페이지로 이동
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) => InitSettingsScreen()), (route) => false);
                                      box.delete('user');
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          CharacterModel? characterModel =
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => AddCharacterScreen()));
                          if (characterModel != null) {
                            list.add(characterModel);
                            box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '캐릭터 수동 추가',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '캐릭터 순서 및 삭제',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          _customPopupMenuController.hideMenu();

                          list =
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAndDeleteScreen(list)));
                          setState(() => {});
                          box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '콘텐츠 수정하기',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _customPopupMenuController.hideMenu();
                          toast('수정하고 싶은 캐릭터의 이름을 1초간 터치해 주세요.');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.grey, width: 0.8),
              ),
              margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Text(
                      '원정대 콘텐츠',
                      style: TextStyle(fontSize: 17, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset('assets/expedition/Rehearsal.png', width: 25, height: 25),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '리허설',
                                      style: contentStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.rehearsalCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.rehearsalCheck = value!;
                                            box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                                          });
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset('assets/expedition/Dejavu.png', width: 25, height: 25),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '데자뷰',
                                      style: contentStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.dejavuCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.dejavuCheck = value!;
                                            box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                                          });
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset('assets/expedition/ChallengeAbyss.png', width: 25, height: 25),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '도전 어비스',
                                      style: contentStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.challengeAbyssCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.challengeAbyssCheck = value!;
                                            box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                                          });
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset('assets/expedition/GhostShip.png', width: 25, height: 25),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '유령선',
                                      style: contentStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.ghostShipCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.ghostShipCheck = value!;
                                            box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                                          });
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// 캐릭터 ExpansionPanel
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.grey, width: 0.8),
                ),
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    String level = list[i].level;
                    bool dailyEmptyCheck = dailyEmptyChecking(list[i].dailyContentList);
                    bool weeklyEmptyCheck = weeklyEmptyChecking(list[i].weeklyContentList);
                    bool dailyClearCheck = dailyClearChecking(list[i].dailyContentList);
                    bool weeklyClearCheck = weeklyClearChecking(list[i].weeklyContentList);
                    // AdWidget adWidget = AdWidget(ad: myBanner);

                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
                      child: ExpansionPanelList(
                        animationDuration: Duration(microseconds: 1000),
                        expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
                        elevation: 1,
                        children: [
                          ExpansionPanel(
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return InkWell(
                                  child: Container(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                  child: Text(
                                                    list[i].nickName.toString(),
                                                    style: contentStyle,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Lv.$level ${list[i].job}',
                                                        style: contentStyle.copyWith(color: Colors.grey, fontSize: 14)),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Row(
                                                      children: [
                                                        list[i].dailyContentList[0].isChecked
                                                            ? Row(
                                                                children: [
                                                                  Image.asset(
                                                                    '${list[i].dailyContentList[0].iconName}',
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                                    child: Container(
                                                                        width: 30,
                                                                        child: Text('${list[i].dailyContentList[0].restGauge}',
                                                                            style: contentStyle.copyWith(fontSize: 14))),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(),
                                                        list[i].dailyContentList[1].isChecked
                                                            ? Row(
                                                                children: [
                                                                  Image.asset(
                                                                    '${list[i].dailyContentList[1].iconName}',
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                                    child: Container(
                                                                        width: 30,
                                                                        child: Text('${list[i].dailyContentList[1].restGauge}',
                                                                            style: contentStyle.copyWith(fontSize: 14))),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(),
                                                        list[i].dailyContentList[2].isChecked
                                                            ? Row(
                                                                children: [
                                                                  Image.asset(
                                                                    '${list[i].dailyContentList[2].iconName}',
                                                                    width: 25,
                                                                    height: 25,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(left: 5),
                                                                    child: Container(
                                                                        width: 30,
                                                                        child: Text('${list[i].dailyContentList[2].restGauge}',
                                                                            style: contentStyle.copyWith(fontSize: 14))),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                clearIcon('일일', Colors.red, dailyEmptyCheck, dailyClearCheck),
                                                clearIcon('주간', Colors.indigo, weeklyEmptyCheck, weeklyClearCheck)
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                  onLongPress: () async {
                                    list[i] = await Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => ContentSettingsScreen(list[i])));
                                    box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                                    setState(() {});
                                  },
                                  onTap: () {
                                    setState(() {
                                      list[i].expanded = !list[i].expanded;
                                    });
                                  },
                                );
                              },
                              body: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      dailyEmptyCheck
                                          ? Container()
                                          : Flexible(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '일일 콘텐츠',
                                                    style: contentStyle,
                                                  ),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: list[i].dailyContentList.length,
                                                    itemBuilder: (context, index) {
                                                      if (list[i].dailyContentList[index] is RestGaugeContent) {
                                                        int saveRestGauge = 0;
                                                        DateTime saveLateRevision = list[i].dailyContentList[index].lateRevision;
                                                        return InkWell(
                                                          child: restGaugeContentTile(list[i].dailyContentList[index]),
                                                          onTap: () {
                                                            setState(() {
                                                              if (list[i].dailyContentList[index].maxClearNum !=
                                                                  list[i].dailyContentList[index].clearNum) {
                                                                list[i].dailyContentList[index].clearNum += 1;
                                                                list[i].dailyContentList[index].lateRevision = DateTime.now();
                                                                if (list[i].dailyContentList[index].restGauge >= 20) {
                                                                  list[i].dailyContentList[index].restGauge =
                                                                      list[i].dailyContentList[index].restGauge - 20;
                                                                  // print(list[i].dailyContentList[index].restGauge);
                                                                  list[i].dailyContentList[index].saveRestGauge += 20;
                                                                  // print('saveRestGauge + : ${list[i].dailyContentList[index].saveRestGauge}');
                                                                }
                                                              } else if (list[i].dailyContentList[index].maxClearNum ==
                                                                  list[i].dailyContentList[index].clearNum) {
                                                                // print('saveRestGauge : $saveRestGauge');
                                                                list[i].dailyContentList[index].clearNum = 0;
                                                                list[i].dailyContentList[index].restGauge =
                                                                    list[i].dailyContentList[index].restGauge +
                                                                        list[i].dailyContentList[index].saveRestGauge;
                                                                list[i].dailyContentList[index].saveRestGauge = 0;
                                                                list[i].dailyContentList[index].lateRevision = saveLateRevision;
                                                              }
                                                              box.put('user',
                                                                  User(characterList: list, expeditionModel: expeditionModel));
                                                            });
                                                          },
                                                        );
                                                      } else {
                                                        return InkWell(
                                                          child: Card(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                      child: Image.asset(
                                                                          '${list[i].dailyContentList[index].iconName}',
                                                                          width: 25,
                                                                          height: 25),
                                                                    ),
                                                                    Text(list[i].dailyContentList[index].name),
                                                                  ],
                                                                ),
                                                                Checkbox(
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  value: list[i].dailyContentList[index].clearCheck,
                                                                  checkColor: Color.fromRGBO(119, 210, 112, 1),
                                                                  activeColor: Colors.transparent,
                                                                  side: BorderSide(color: Colors.grey, width: 1.5),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(3)),
                                                                  onChanged: (bool? value) {
                                                                    setState(() {
                                                                      list[i].dailyContentList[index].clearCheck =
                                                                          !list[i].dailyContentList[index].clearCheck;
                                                                      box.put(
                                                                          'user',
                                                                          User(
                                                                              characterList: list,
                                                                              expeditionModel: expeditionModel));
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              list[i].dailyContentList[index].clearCheck =
                                                                  !list[i].dailyContentList[index].clearCheck;
                                                              box.put('user',
                                                                  User(characterList: list, expeditionModel: expeditionModel));
                                                            });
                                                          },
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                      weeklyEmptyCheck
                                          ? Container()
                                          : Flexible(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '주간 콘텐츠',
                                                    style: contentStyle,
                                                  ),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: list[i].weeklyContentList.length,
                                                    itemBuilder: (context, index) {
                                                      if (list[i].weeklyContentList[index].isChecked == true) {
                                                        return InkWell(
                                                          child: Card(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                                      child: Image.asset(
                                                                          '${list[i].weeklyContentList[index].iconName}',
                                                                          width: 25,
                                                                          height: 25),
                                                                    ),
                                                                    Text(
                                                                      list[i].weeklyContentList[index].name,
                                                                      style: contentStyle,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Checkbox(
                                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                  value: list[i].weeklyContentList[index].clearCheck,
                                                                  checkColor: Color.fromRGBO(119, 210, 112, 1),
                                                                  activeColor: Colors.transparent,
                                                                  side: BorderSide(color: Colors.grey, width: 1.5),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(3),
                                                                  ),
                                                                  onChanged: (bool? value) {
                                                                    setState(() {
                                                                      list[i].weeklyContentList[index].clearCheck =
                                                                          !list[i].weeklyContentList[index].clearCheck;
                                                                      box.put(
                                                                          'user',
                                                                          User(
                                                                              characterList: list,
                                                                              expeditionModel: expeditionModel));
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              list[i].weeklyContentList[index].clearCheck =
                                                                  !list[i].weeklyContentList[index].clearCheck;
                                                              box.put('user',
                                                                  User(characterList: list, expeditionModel: expeditionModel));
                                                            });
                                                          },
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                  StatefulBuilder(
                                    builder: (context, setState) => Container(
                                      child: AdWidget(ad: list[i].bannerAd),
                                      width: list[i].bannerAd.size.width.toDouble(),
                                      height: 100.0,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ],
                              ),
                              isExpanded: list[i].expanded,
                              canTapOnHeader: true),
                        ],
                        // ExpansionTile 확장
                        expansionCallback: (int item, bool isExpanded) {
                          setState(() {
                            list[i].expanded = !list[i].expanded;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget restGaugeContentTile(RestGaugeContent restGaugeContent) {
    if (restGaugeContent.isChecked == false) {
      return Container();
    } else {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Image.asset('${restGaugeContent.iconName}', width: 25, height: 25),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                  child: Text(
                    restGaugeContent.name,
                    style: contentStyle,
                  ),
                ),
              ],
            ),
            restGaugeContent.clearNum == restGaugeContent.maxClearNum
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.check,
                      color: Color.fromRGBO(119, 210, 112, 1),
                      size: 20,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      '${restGaugeContent.clearNum} / ${restGaugeContent.maxClearNum}',
                      style: contentStyle,
                    ),
                  )
          ],
        ),
      );
    }
  }

  Widget dailyContentTile(DailyContent dailyContent, int index) {
    return dailyContent.isChecked == false
        ? Container()
        : Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Image.asset('${dailyContent.iconName}', width: 25, height: 25),
                    ),
                    Text(dailyContent.name),
                  ],
                ),
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: dailyContent.clearCheck,
                  onChanged: (bool? value) {
                    setState(() {});
                  },
                )
              ],
            ),
          );
  }

  Widget weeklyContentTile(WeeklyContent weeklyContent, int index) {
    if (weeklyContent.isChecked == false) {
      return Container();
    } else {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Image.asset('${weeklyContent.iconName}', width: 25, height: 25),
                ),
                Text(weeklyContent.name),
              ],
            ),
            Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: weeklyContent.clearCheck,
              onChanged: (bool? value) {},
            )
          ],
        ),
      );
    }
  }

  String levelText(String level) {
    int start = level.indexOf('.') + 1;
    int end = level.lastIndexOf('.');
    return 'Lv.' + level.substring(start, end);
  }

  bool dailyEmptyChecking(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].isChecked == true) {
        return false;
      }
    }
    return true;
  }

  bool weeklyEmptyChecking(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].isChecked == true) {
        return false;
      }
    }
    return true;
  }

  bool dailyClearChecking(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i] is RestGaugeContent && list[i].isChecked == true && list[i].clearNum != list[i].maxClearNum) {
        return false;
      } else if (list[i] is DailyContent && list[i].clearCheck == false) {
        return false;
      }
    }
    return true;
  }

  bool weeklyClearChecking(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].clearCheck == false && list[i].isChecked == true) {
        return false;
      }
    }
    return true;
  }

  Widget clearIcon(String type, Color color, bool empty, bool dailyClear) {
    if (empty == true) {
      return Container();
    } else if (empty == false && dailyClear == true) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                '$type',
                style: contentStyle.copyWith(fontSize: 16, color: color),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              child: Image.asset(
                'assets/etc/check_circle.png',
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                '$type',
                style: contentStyle.copyWith(fontSize: 16, color: color),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              child: Image.asset(
                'assets/etc/warning2_circle.png',
              ),
            ),
          ],
        ),
      );
    }
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }
  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }
}
