import 'package:adeline_app/constant.dart';
import 'package:adeline_app/model/user/characterModel/characterModel.dart';
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
  bool _isCheck = false;

  @override
  void initState() {
    super.initState();
    list = Hive.box<User>('localDB').get('user')!.characterList;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Adeline Project'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '원정대 컨텐츠',
                    style: TextStyle(
                        fontSize: 19, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        elevation: 2,
                        child: InkWell(
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  // 비활성화 위젯
                                  // Image.asset('assets/expedition/ChaosGate.png',width: 40,height: 40,colorBlendMode: BlendMode.color,color: Colors.white,),
                                  Image.asset('assets/expedition/Island.png',
                                      width: 30, height: 30),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              )),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: InkWell(
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  // 비활성화 위젯
                                  // Image.asset('assets/expedition/ChaosGate.png',width: 30,height: 30,colorBlendMode: BlendMode.color,color: Colors.white,),
                                  Image.asset('assets/expedition/ChaosGate.png',
                                      width: 30, height: 30),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              )),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: InkWell(
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  // 비활성화 위젯
                                  // Image.asset('assets/expedition/ChaosGate.png',width: 30,height: 30,colorBlendMode: BlendMode.color,color: Colors.white,),
                                  Image.asset('assets/expedition/FieldBoss.png',
                                      width: 30, height: 30),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                ],
                              )),
                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: InkWell(
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  // 비활성화 위젯
                                  // Image.asset('assets/expedition/ChaosGate.png',width: 30,height: 30,colorBlendMode: BlendMode.color,color: Colors.white,),
                                  Image.asset('assets/expedition/GhostShip.png',
                                      width: 30, height: 30),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: Colors.black,
                                    size: 20,
                                  )
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
                                  Image.asset(
                                    'assets/expedition/ChallengeAbyss.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('도전 어비스')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
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
                                  Image.asset(
                                    'assets/expedition/Dungeon.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('혼돈의 사선')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
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
                                  Image.asset(
                                    'assets/expedition/LikeAbility.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('호감도')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
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
                                  Image.asset(
                                    'assets/expedition/GhostShip.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('유령선')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
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
                                  Image.asset(
                                    'assets/expedition/Rehearsal.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('리허설')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
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
                                  Image.asset(
                                    'assets/expedition/Dejavu.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('데자뷰')
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
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
                ],
              ),
            ),
            Card(
              elevation: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '성우웅',
                          style: titleStyle.copyWith(fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Text(
                        'Lv.1485',
                        style: TextStyle(color: Colors.grey[600], fontSize: 11),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10,0,0,0),
                            child: Text('휴식게이지',style: TextStyle(color: Colors.grey[700],fontSize: 12,fontWeight: FontWeight.bold),),
                          ),
                          Row(
                            children: [
                              Card(
                                elevation: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/daily/Chaos.png',width: 25,height: 25,),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('60',style: TextStyle(fontSize: 16),),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/daily/Guardian.png',width: 25,height: 25,),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('40',style: TextStyle(fontSize: 16),),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/daily/Epona.png',width: 25,height: 25,),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('40',style: TextStyle(fontSize: 16),),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          child: Column(
                            children: [
                              Text('일일 컨텐츠'),
                              Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Card(
                                      child: Text('오레하의 우물우물'),
                                    ),
                                    Card(
                                      child: Text('오레하의 우물우물'),
                                    ),
                                    Card(
                                      child: Text('오레하의 우물우물'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      Flexible(
                          child: Column(
                            children: [
                              Text('주간 컨텐츠'),
                              Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Card(
                                      child: Text('오레하의 우물우물'),
                                    ),
                                    Card(
                                      child: Text('오레하의 우물우물'),
                                    ),
                                    Card(
                                      child: Text('오레하의 우물우물'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
