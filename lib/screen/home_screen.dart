import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:adeline_app/model/user/content/dailyContent.dart';
import 'package:adeline_app/model/user/content/restGaugeContent.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:adeline_app/model/user/expeditionModel.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';

import '../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CharacterModel> list;
  late ExpeditionModel expeditionModel;
  final box = Hive.box<User>('localDB');
  bool blankCheckbox = true;
  bool dailyTitleColor = true;
  bool weeklyTitleColor = true;
  bool disableChaosGate = false;
  bool disableFieldBoss = false;
  bool disableGhostShip = false;
  List<Widget> listCard = [];

  @override
  void initState() {
    super.initState();
    list = Hive.box<User>('localDB').get('user')!.characterList;
    for (int i = 0; i < list.length; i++) {
      for (int j = 0; j < list[i].dailyContentList.length; j++) {
        if (list[i].dailyContentList[j] is RestGaugeContent) {
          list[i].dailyContentList[j].saveRestGauge = 0;
          DateTime lateRevision = list[i].dailyContentList[j].lateRevision;
          print('${list[i].nickName} : ${list[i].dailyContentList[j].lateRevision}');
          int clearNum = list[i].dailyContentList[j].clearNum;
          int maxClearNum = list[i].dailyContentList[j].maxClearNum;
          DateTime now = DateTime.now();

          /// 현재시간과 최근수정일에 일수 차이가 0 일때
          /// 기존 휴식게이지 출력
          if (list[i].dailyContentList[j].restGauge >= 100) {
            print('로직1');
            list[i].dailyContentList[j].restGauge = 100;
          } else if (DateTime.now().difference(lateRevision).inDays == 0) {
            print('로직2');
            list[i].dailyContentList[j].restGauge = list[i].dailyContentList[j].restGauge;
          }

          /// 현재시간과 최근수정일이 1일 차이 일때
          else if (DateTime.now().difference(lateRevision).inDays <= 1 && DateTime.now().difference(lateRevision).inDays > 0) {
            /// 오전 6시 전 이면 기존 휴식게이지 출력
            if (DateTime.now().hour < 6) {
              print('로직3');
              list[i].dailyContentList[j].restGauge = list[i].dailyContentList[j].restGauge;
              list[i].dailyContentList[j].clearNum = 0;
            }

            /// 오전 6시 후 면 전날 남은횟수 * 10 해서 휴식게이지 출력
            else if (DateTime.now().hour >= 6) {
              print('로직4');
              list[i].dailyContentList[j].restGauge = (maxClearNum - clearNum) * 10;
              list[i].dailyContentList[j].clearNum = 0;
            }
          }

          /// 현재시간과 최근수정일이 이틀 이상 일때
          else if (DateTime.now().difference(lateRevision).inDays > 1) {
            if (DateTime.now().hour < 6) {
              print('로직5');
              int a = DateTime.utc(now.year, now.month, now.day).difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1)).inDays - 1;
              list[i].dailyContentList[j].restGauge = ((maxClearNum - clearNum) * 10) + (a * maxClearNum * 10);
              list[i].dailyContentList[j].clearNum = 0;
            } else if (DateTime.now().hour >= 6) {
              print('로직6');
              int a = DateTime.utc(now.year, now.month, now.day).difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1)).inDays;
              print('a : $a');
              list[i].dailyContentList[j].restGauge = ((maxClearNum - clearNum) * 10) + (a * maxClearNum * 10);
              if (list[i].dailyContentList[j].restGauge >= 100) {
                list[i].dailyContentList[j].restGauge = 100;
              }
              list[i].dailyContentList[j].clearNum = 0;
            }
          }
        }
      }
    }
    expeditionModel = Hive.box<User>('localDB').get('user')!.expeditionModel!;
    DateTime nowDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6); // 현재날짜 오전6시 기준
    if (nowDate.difference(expeditionModel.recentInitDateTime).inSeconds > 0 && nowDate.weekday == 3) {
      expeditionModel.islandCheck = false;
      expeditionModel.chaosGateCheck = false;
      expeditionModel.fieldBoosCheck = false;
      expeditionModel.ghostShipCheck = false;
      expeditionModel.rehearsalCheck = false;
      expeditionModel.dejavuCheck = false;
      expeditionModel.challengeAbyssCheck = false;
      expeditionModel.likeAbilityCheck = false;
      expeditionModel.chaosLineCheck = false;
    } else if (nowDate.difference(expeditionModel.recentInitDateTime).inSeconds > 0) {
      int week = DateTime.now().weekday;
      switch (week) {
        case 1:
          expeditionModel.islandCheck = false;
          expeditionModel.chaosGateCheck = false;
          disableFieldBoss = true;
          break;
        case 2:
          expeditionModel.islandCheck = false;
          expeditionModel.fieldBoosCheck = false;
          disableChaosGate = true;
          break;
        case 4:
          expeditionModel.islandCheck = false;
          expeditionModel.chaosGateCheck = false;
          disableFieldBoss = true;
          break;
        case 5:
          expeditionModel.islandCheck = false;
          expeditionModel.fieldBoosCheck = false;
          disableChaosGate = true;
          break;
        case 6:
          expeditionModel.islandCheck = false;
          expeditionModel.chaosGateCheck = false;
          disableFieldBoss = true;
          break;
        case 7:
          expeditionModel.islandCheck = false;
          expeditionModel.chaosGateCheck = false;
          expeditionModel.fieldBoosCheck = false;
          break;
      }
    }
    expeditionModel.recentInitDateTime = DateTime.now();
    box.put('user', User(characterList: list, expeditionModel: expeditionModel));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Adeline Project'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// 원정대 컨텐츠 , 카드삭제 고려
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(5),
                  //   child: Text(
                  //     '원정대 컨텐츠',
                  //    style: TextStyle(fontSize: 17, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 2,
                          child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/expedition/LikeAbility.png', width: 30, height: 30),
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.likeAbilityCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.likeAbilityCheck = value!;
                                          });
                                        })
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // 비활성화 위젯
                                    // Image.asset('assets/expedition/ChaosGate.png',width: 30,height: 30,colorBlendMode: BlendMode.color,color: Colors.white,),
                                    Image.asset('assets/expedition/Island.png', width: 30, height: 30),
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.islandCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.islandCheck = value!;
                                          });
                                        })
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // 비활성화 위젯
                                    disableChaosGate
                                        ? Image.asset('assets/expedition/ChaosGate.png', width: 30, height: 30, colorBlendMode: BlendMode.color, color: Colors.white)
                                        : Image.asset('assets/expedition/ChaosGate.png', width: 30, height: 30),
                                    disableChaosGate
                                        ? Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            side: BorderSide(color: Colors.grey, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            onChanged: (bool? value) {},
                                            value: false,
                                          )
                                        : Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: expeditionModel.chaosGateCheck,
                                            checkColor: Color.fromRGBO(119, 210, 112, 1),
                                            activeColor: Colors.transparent,
                                            side: BorderSide(color: Colors.grey, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                expeditionModel.chaosGateCheck = value!;
                                              });
                                            })
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // 비활성화 위젯
                                    disableFieldBoss
                                        ? Image.asset('assets/expedition/FieldBoss.png', width: 30, height: 30, colorBlendMode: BlendMode.color, color: Colors.white)
                                        : Image.asset('assets/expedition/FieldBoss.png', width: 30, height: 30),
                                    disableFieldBoss
                                        ? Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            side: BorderSide(color: Colors.grey, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            onChanged: (bool? value) {},
                                            value: false,
                                          )
                                        : Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: expeditionModel.fieldBoosCheck,
                                            checkColor: Color.fromRGBO(119, 210, 112, 1),
                                            activeColor: Colors.transparent,
                                            side: BorderSide(color: Colors.grey, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                expeditionModel.fieldBoosCheck = value!;
                                              });
                                            })
                                  ],
                                )),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // 비활성화 위젯
                                    disableGhostShip
                                        ? Image.asset('assets/expedition/GhostShip.png', width: 30, height: 30, colorBlendMode: BlendMode.color, color: Colors.white)
                                        : Image.asset('assets/expedition/GhostShip.png', width: 30, height: 30),
                                    disableGhostShip
                                        ? Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            side: BorderSide(color: Colors.grey, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            onChanged: (bool? value) {},
                                            value: false,
                                          )
                                        : Checkbox(
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            value: expeditionModel.ghostShipCheck,
                                            checkColor: Color.fromRGBO(119, 210, 112, 1),
                                            activeColor: Colors.transparent,
                                            side: BorderSide(color: Colors.grey, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(3),
                                            ),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                expeditionModel.ghostShipCheck = value!;
                                              });
                                            })
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 2,
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
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.rehearsalCheck = value!;
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
                            elevation: 2,
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
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.dejavuCheck = value!;
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
                            elevation: 2,
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
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.challengeAbyssCheck = value!;
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
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Image.asset('assets/expedition/Dungeon.png', width: 25, height: 25),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '혼돈의 사선',
                                      style: contentStyle,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: expeditionModel.chaosLineCheck,
                                        checkColor: Color.fromRGBO(119, 210, 112, 1),
                                        activeColor: Colors.transparent,
                                        side: BorderSide(color: Colors.grey, width: 1.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            expeditionModel.chaosLineCheck = value!;
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

              /// 캐릭터 ExpansionPanel
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: ExpansionPanelList(
                  animationDuration: Duration(microseconds: 1300),
                  elevation: 2,
                  expandedHeaderPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  children: list.map<ExpansionPanel>((CharacterModel characterModel) {
                    // 여기서 모든 로직이 완성되어야 된다.
                    String level = characterModel.level;
                    bool dailyEmptyCheck = dailyEmptyChecking(characterModel.dailyContentList);
                    bool weeklyEmptyCheck = weeklyEmptyChecking(characterModel.weeklyContentList);

                    return ExpansionPanel(
                      isExpanded: characterModel.expanded,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              characterModel.nickName.toString(),
                              style: contentStyle,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${levelText(level)} ${characterModel.job}',
                                style: contentStyle.copyWith(color: Colors.grey, fontSize: 14),
                              ),
                              Row(
                                children: [
                                  characterModel.dailyContentList[0].isChecked
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              '${characterModel.dailyContentList[0].iconName}',
                                              width: 25,
                                              height: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 10),
                                              child: Text('${characterModel.dailyContentList[0].restGauge}', style: TextStyle(fontSize: 15, color: Colors.black)),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  characterModel.dailyContentList[1].isChecked
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              '${characterModel.dailyContentList[1].iconName}',
                                              width: 25,
                                              height: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 10),
                                              child: Text('${characterModel.dailyContentList[1].restGauge}', style: TextStyle(fontSize: 15, color: Colors.black)),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  characterModel.dailyContentList[2].isChecked
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              '${characterModel.dailyContentList[2].iconName}',
                                              width: 25,
                                              height: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5, right: 10),
                                              child: Text('${characterModel.dailyContentList[2].restGauge}', style: TextStyle(fontSize: 15, color: Colors.black)),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      body: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          dailyEmptyCheck
                              ? Container()
                              : Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        '일일 컨텐츠',
                                        style: contentStyle,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: characterModel.dailyContentList.length,
                                        itemBuilder: (context, index) {
                                          if (characterModel.dailyContentList[index] is RestGaugeContent) {
                                            int saveRestGauge = 0;
                                            DateTime saveLateRevision = characterModel.dailyContentList[index].lateRevision;
                                            return InkWell(
                                              child: restGaugeContentTile(characterModel.dailyContentList[index]),
                                              onTap: () {
                                                setState(() {
                                                  if (characterModel.dailyContentList[index].maxClearNum != characterModel.dailyContentList[index].clearNum) {
                                                    characterModel.dailyContentList[index].clearNum += 1;
                                                    characterModel.dailyContentList[index].lateRevision = DateTime.now();
                                                    if (characterModel.dailyContentList[index].restGauge >= 20) {
                                                      characterModel.dailyContentList[index].restGauge = characterModel.dailyContentList[index].restGauge - 20;
                                                      print(characterModel.dailyContentList[index].restGauge);
                                                      characterModel.dailyContentList[index].saveRestGauge += 20;
                                                      print('saveRestGauge + : ${characterModel.dailyContentList[index].saveRestGauge}');
                                                    }
                                                  } else if (characterModel.dailyContentList[index].maxClearNum == characterModel.dailyContentList[index].clearNum) {
                                                    print('saveRestGauge : $saveRestGauge');
                                                    characterModel.dailyContentList[index].clearNum = 0;
                                                    characterModel.dailyContentList[index].restGauge =
                                                        characterModel.dailyContentList[index].restGauge + characterModel.dailyContentList[index].saveRestGauge;
                                                    characterModel.dailyContentList[index].saveRestGauge = 0;
                                                    characterModel.dailyContentList[index].lateRevision = saveLateRevision;
                                                  }
                                                  print('저장?');
                                                  box.put('user', User(characterList: list, expeditionModel: expeditionModel));
                                                });
                                              },
                                            );
                                          } else {
                                            return InkWell(
                                              child: dailyContentTile(characterModel.dailyContentList[index], index),
                                              onTap: () {
                                                box.put('user', User(characterList: list, expeditionModel: expeditionModel));
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
                                        '주간 컨텐츠',
                                        style: contentStyle,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: characterModel.weeklyContentList.length,
                                        itemBuilder: (context, index) {
                                          if (characterModel.weeklyContentList[index].isChecked == true) {
                                            return InkWell(
                                              child: Card(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                          child: Image.asset('${characterModel.weeklyContentList[index].iconName}', width: 25, height: 25),
                                                        ),
                                                        Text(
                                                          characterModel.weeklyContentList[index].name,
                                                          style: contentStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    Checkbox(
                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                      value: characterModel.weeklyContentList[index].clearCheck,
                                                      checkColor: Color.fromRGBO(119, 210, 112, 1),
                                                      activeColor: Colors.transparent,
                                                      side: BorderSide(color: Colors.grey, width: 1.5),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(3),
                                                      ),
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          characterModel.weeklyContentList[index].clearCheck = !characterModel.weeklyContentList[index].clearCheck;
                                                          box.put('user', User(characterList: list, expeditionModel: expeditionModel));

                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  characterModel.weeklyContentList[index].clearCheck = !characterModel.weeklyContentList[index].clearCheck;
                                                  box.put('user', User(characterList: list, expeditionModel: expeditionModel));
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
                    );
                  }).toList(),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      list[index].expanded = !isExpanded;
                    });
                  },
                ),
              )
            ],
          ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: restGaugeContent.clearNum == restGaugeContent.maxClearNum ? Icon(Icons.check,color: Color.fromRGBO(119, 210, 112, 1),size: 20,): Text(
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

  List<Widget> restGaugeNumber(CharacterModel characterModel) {
    List<Widget> listCard = [];
    for (int i = 0; i < characterModel.dailyContentList.length; i++) {
      if (characterModel.dailyContentList[i] is RestGaugeContent && characterModel.dailyContentList[i].isChecked) {
        DateTime lateRevision = characterModel.dailyContentList[i].lateRevision; // 테스트 할때 이부분 수정
        // DateTime lateRevision = DateTime.utc(2021, 10, 4); // 테스트 할때 이부분 수정
        int clearNum = characterModel.dailyContentList[i].clearNum;
        int maxClearNum = characterModel.dailyContentList[i].maxClearNum;
        DateTime now = DateTime.now();

        /// 현재시간과 최근수정일에 일수 차이가 0 일때
        /// 기존 휴식게이지 출력
        if (characterModel.dailyContentList[i].restGauge >= 100) {
          characterModel.dailyContentList[i].restGauge = 100;
        } else if (DateTime.now().difference(lateRevision).inDays == 0) {
          characterModel.dailyContentList[i].restGauge = characterModel.dailyContentList[i].restGauge;
        }

        /// 현재시간과 최근수정일이 1일 차이 일때
        else if (DateTime.now().difference(lateRevision).inDays <= 1 && DateTime.now().difference(lateRevision).inDays > 0) {
          /// 오전 6시 전 이면 기존 휴식게이지 출력
          if (DateTime.now().hour < 6) {
            characterModel.dailyContentList[i].restGauge = characterModel.dailyContentList[i].restGauge;
          }

          /// 오전 6시 후 면 전날 남은횟수 * 10 해서 휴식게이지 출력
          else if (DateTime.now().hour >= 6) {
            characterModel.dailyContentList[i].restGauge = (maxClearNum - clearNum) * 10;
          }
        }

        /// 현재시간과 최근수정일이 이틀 이상 일때
        else if (DateTime.now().difference(lateRevision).inDays > 1) {
          if (DateTime.now().hour < 6) {
            int a = DateTime.utc(now.year, now.month, now.day).difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1)).inDays - 1;
            characterModel.dailyContentList[i].restGauge = ((maxClearNum - clearNum) * 10) + (a * maxClearNum * 10);
          } else if (DateTime.now().hour >= 6) {
            int a = DateTime.utc(now.year, now.month, now.day).difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1)).inDays;
            characterModel.dailyContentList[i].restGauge = ((maxClearNum - clearNum) * 10) + (a * maxClearNum * 10);
          }
        }
        listCard.add(Row(
          children: [
            Image.asset(
              '${characterModel.dailyContentList[i].iconName}',
              width: 25,
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: Text('${characterModel.dailyContentList[i].restGauge}', style: TextStyle(fontSize: 15, color: Colors.black)),
            ),
          ],
        ));
      }
    }
    return listCard;
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
}
