import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:adeline_app/model/user/content/dailyContent.dart';
import 'package:adeline_app/model/user/content/restGaugeContent.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:adeline_app/model/user/expeditionModel.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CharacterModel> list = [];
  final box = Hive.box<User>('localDB');
  bool _isCheck = false;
  bool dailyTitleColor = true;
  bool weeklyTitleColor = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list = Hive.box<User>('localDB').get('user')!.characterList;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Adeline Project'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// 원정대 컨텐츠 , 카드삭제 고려
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '원정대 컨텐츠',
                      style: TextStyle(fontSize: 16, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          elevation: 2,
                          child: InkWell(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // 비활성화 위젯
                                    // Image.asset('assets/expedition/ChaosGate.png',width: 40,height: 40,colorBlendMode: BlendMode.color,color: Colors.white,),
                                    Image.asset('assets/expedition/Island.png', width: 30, height: 30),
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                                    Image.asset('assets/expedition/ChaosGate.png', width: 30, height: 30),

                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                                    Image.asset('assets/expedition/FieldBoss.png', width: 30, height: 30),

                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                                    Image.asset('assets/expedition/GhostShip.png', width: 30, height: 30),
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
                                          });
                                        })
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/expedition/ChallengeAbyss.png', width: 30, height: 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('도전 어비스')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                                    Image.asset('assets/expedition/Dungeon.png', width: 30, height: 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('혼돈의 사선')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/expedition/Rehearsal.png', width: 30, height: 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('리허설')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                                    Image.asset('assets/expedition/Dejavu.png', width: 30, height: 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('데자뷰')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/expedition/LikeAbility.png', width: 30, height: 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('호감도')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        value: _isCheck,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isCheck = value!;
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
                                    Image.asset('assets/etc/Gold.png', width: 30, height: 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('골드 획득량')
                                  ],
                                ),
                                Row(
                                  children: [Text('21500')],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// 캐릭터 ExpansionPanel
              Container(
                margin: EdgeInsets.all(8),
                child: ExpansionPanelList(
                  animationDuration: Duration(microseconds: 1000),
                  elevation: 2,
                  expandedHeaderPadding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  children: list.map<ExpansionPanel>((CharacterModel characterModel) {
                    // 여기서 모든 로직이 완성되어야 된다.
                    String level = characterModel.level;
                    bool dailyEmptyCheck = dailyEmptyChecking(characterModel.dailyContentList);
                    bool weeklyEmptyCheck = weeklyEmptyChecking(characterModel.weeklyContentList);
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

                    return ExpansionPanel(
                      isExpanded: characterModel.expanded,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Text(
                              characterModel.nickName.toString(),
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('${levelText(level)} ${characterModel.job} '), Row(children: listCard)],
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
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: characterModel.dailyContentList.length,
                                        itemBuilder: (context, index) {
                                          if (characterModel.dailyContentList[index] is RestGaugeContent) {
                                            return InkWell(
                                              child: restGaugeContentTile(characterModel.dailyContentList[index]),
                                              onTap: () {
                                                setState(() {
                                                  if (characterModel.dailyContentList[index].clearNum == characterModel.dailyContentList[index].maxClearNum) {
                                                    characterModel.dailyContentList[index].clearNum = 0;
                                                    characterModel.dailyContentList[index].lateRevision = DateTime.now();
                                                    if (characterModel.dailyContentList[index].restGauge >= 20) {
                                                      characterModel.dailyContentList[index].restGauge -= 20;
                                                    } else if(characterModel.dailyContentList[index].restGauge != 0) {
                                                      characterModel.dailyContentList[index].restGauge = (20 * characterModel.dailyContentList[index].maxClearNum);
                                                    }
                                                  } else if (characterModel.dailyContentList[index].maxClearNum > characterModel.dailyContentList[index].clearNum) {
                                                    characterModel.dailyContentList[index].clearNum += 1;
                                                    characterModel.dailyContentList[index].lateRevision = DateTime.now();
                                                    if (characterModel.dailyContentList[index].restGauge >= 20) {
                                                      characterModel.dailyContentList[index].restGauge -= 20;
                                                    }
                                                  }
                                                  box.put('user', User(characterList: list, expeditionModel: ExpeditionModel()));
                                                });

                                              },
                                            );
                                          } else {
                                            return InkWell(
                                              child: dailyContentTile(characterModel.dailyContentList[index], index),
                                              onTap: () {
                                                box.put('user', User(characterList: list, expeditionModel: ExpeditionModel()));
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
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: characterModel.weeklyContentList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
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
                                                      Text(characterModel.weeklyContentList[index].name),
                                                    ],
                                                  ),
                                                  Checkbox(
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    value: characterModel.weeklyContentList[index].clearCheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        characterModel.weeklyContentList[index].clearCheck = !characterModel.weeklyContentList[index].clearCheck;
                                                      });
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                characterModel.weeklyContentList[index].clearCheck = !characterModel.weeklyContentList[index].clearCheck;
                                              });
                                            },
                                          );
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
                  child: Text(restGaugeContent.name),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Text('${restGaugeContent.clearNum} / ${restGaugeContent.maxClearNum}'),
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
