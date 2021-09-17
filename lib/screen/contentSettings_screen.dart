import 'package:adeline_app/constant.dart';
import 'package:adeline_app/model/characterModel.dart';
import 'package:adeline_app/model/dailyContent.dart';
import 'package:adeline_app/model/weeklyContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ContentSettingsScreen extends StatefulWidget {
  final charInfo;

  ContentSettingsScreen(this.charInfo);

  @override
  _ContentSettingsScreenState createState() => _ContentSettingsScreenState();
}

class _ContentSettingsScreenState extends State<ContentSettingsScreen> {
  bool _isChecked = false;
  int? _selected;
  int num1 = 0;
  int num2 = 0;
  String? iconName;
  late CharacterModel characterModel;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController(text: 'Hello World!');
  List<Card> dailyCardList = [];
  List<Card> weeklyCardList = [];

  @override
  void initState() {
    super.initState();
    characterModel = widget.charInfo;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('컨텐츠 설정', style: contentStyle.copyWith(fontSize: 15, color: Colors.black)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, characterModel);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                '일일 컨텐츠',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 30,
                                onPressed: () async {
                                  controller.clear();
                                  await showDialog(
                                      context: context,
                                      builder: (_) {
                                        return StatefulBuilder(builder: (context, setState) {
                                          return AlertDialog(
                                            title: Form(
                                              key: key,
                                              child: TextFormField(
                                                controller: controller,
                                              ),
                                            ),
                                            content: Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              child: GridView.builder(
                                                  itemCount: iconList.length,
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  gridDelegate:
                                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 65,
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 10,
                                                  ),
                                                  itemBuilder: (_, index) {
                                                    // list[index] = IconModel(list[index].iconName);
                                                    return Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: InkWell(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(10),
                                                              border: Border.all(
                                                                  color: _selected == index
                                                                      ? Colors.grey
                                                                      : Colors.white,
                                                                  width: 1.5)),
                                                          child: Image.asset(
                                                            '${iconList[index].iconName}',
                                                            width: 100,
                                                            height: 100,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            _selected = index;
                                                            iconName = iconList[index].iconName;
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      characterModel.dailyContentList.add(
                                                          DailyContent(controller.text.toString(),
                                                              iconName.toString(), true));
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('확인'),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('취소')),
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                      });
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 7),
                                  child: dailyContents(),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                '주간 컨텐츠',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontFamily: 'NotoSansKR',
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 30,
                                onPressed: () async {
                                  controller.clear();
                                  await showDialog(
                                      context: context,
                                      builder: (_) {
                                        return StatefulBuilder(builder: (context, setState) {
                                          return AlertDialog(
                                            title: Form(
                                              key: key,
                                              child: TextFormField(
                                                controller: controller,
                                              ),
                                            ),
                                            content: Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              child: GridView.builder(
                                                  itemCount: iconList.length,
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 65,
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 10,
                                                  ),
                                                  itemBuilder: (_, index) {
                                                    // list[index] = IconModel(list[index].iconName);
                                                    return Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: InkWell(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                              border: Border.all(
                                                                  color: _selected == index
                                                                      ? Colors.grey
                                                                      : Colors.white,
                                                                  width: 1.5)),
                                                          child: Image.asset(
                                                            '${iconList[index].iconName}',
                                                            width: 100,
                                                            height: 100,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          setState(() {
                                                            _selected = index;
                                                            iconName = iconList[index].iconName;
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      characterModel.weeklyContentList.add(
                                                          WeeklyContent(controller.text.toString(),
                                                              iconName.toString(), true));
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('확인'),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('취소')),
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                      });
                                  setState(() {});
                                },
                              ),
                            )
                          ],
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 7),
                                  child: cropsContents(),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// 태양의 회랑 및 디멘션 큐브 티켓 갯수 추후 추가예
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(color: Colors.black26, width: 1),
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.only(left: 15),
                //               child: Text(
                //                 '기타 컨텐츠',
                //                 style: TextStyle(
                //                     fontSize: 19,
                //                     fontFamily: 'NotoSansKR',
                //                     fontWeight: FontWeight.w300),
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(right: 5),
                //               child: IconButton(
                //                 icon: Icon(Icons.add),
                //                 iconSize: 30,
                //                 onPressed: () {},
                //               ),
                //             )
                //           ],
                //         ),
                //         ConstrainedBox(
                //           constraints: BoxConstraints(),
                //           child: Padding(
                //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                //             child: ListView(
                //               shrinkWrap: true,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.fromLTRB(10, 0, 10, 7),
                //                   child: ticketContents(),
                //                 )
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }

  /// 추후 body - column 안에 있는 padding 3개를정
  /// dailyContents 로 병합하기
  Widget dailyContents() {
    dailyCardList = [];
    for (int i = 0; i < characterModel.dailyContentList.length; i++) {
      Card card = Card(
        elevation: 2,
        child: CheckboxListTile(
          title: InkWell(
            child: Row(
              children: [
                Image.asset(
                  characterModel.dailyContentList[i].iconName,
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                PlatformWidget(
                  cupertino: (_, __) => Text(
                    characterModel.dailyContentList[i].name,
                    style: contentStyle,
                  ),
                  material: (_, __) => Text(''),
                ),
              ],
            ),
            onTap: () async {
              controller.text = '${characterModel.dailyContentList[i].name}';
              await showDialog(
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Form(
                          key: key,
                          child: TextFormField(
                            controller: controller,
                          ),
                        ),
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: GridView.builder(
                              itemCount: iconList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 65,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (_, index) {
                                // list[index] = IconModel(list[index].iconName);
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color:
                                                  _selected == index ? Colors.grey : Colors.white,
                                              width: 1.5)),
                                      child: Image.asset(
                                        '${iconList[index].iconName}',
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selected = index;
                                        iconName = iconList[index].iconName;
                                      });
                                    },
                                  ),
                                );
                              }),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  characterModel.dailyContentList[i] =
                                      DailyContent(controller.text, iconName.toString(), true);
                                  Navigator.pop(context);
                                },
                                child: Text('확인'),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소')),
                            ],
                          )
                        ],
                      );
                    });
                  });
              setState(() {});
            },
          ),

          /// _isChecked 를 characterModel -> dailyContent 에서 가져오기
          /// model 에 _isChecked bool 형태로 추가하기
          value: characterModel.dailyContentList[i].isChecked,
          onChanged: (value) {
            setState(() {
              characterModel.dailyContentList[i].isChecked = value!;
            });
          },
          // CheckBoxTile 위아래 padding 삭제
          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        ),
      );
      dailyCardList.add(card);
    }
    return Column(children: dailyCardList);
  }

  Widget cropsContents() {
    weeklyCardList = [];
    for (int i = 0; i < characterModel.weeklyContentList.length; i++) {
      Card card = Card(
        elevation: 2,
        child: CheckboxListTile(
          title: InkWell(
            child: Row(
              children: [
                Image.asset(
                  characterModel.weeklyContentList[i].iconName,
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                PlatformWidget(
                  cupertino: (_, __) => Text(
                    characterModel.weeklyContentList[i].name,
                    style: contentStyle,
                  ),
                  material: (_, __) => Text(''),
                ),
              ],
            ),
            onTap: () async {
              controller.text = '${characterModel.weeklyContentList[i].name}';
              await showDialog(
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Form(
                          key: key,
                          child: TextFormField(
                            controller: controller,
                          ),
                        ),
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: GridView.builder(
                              itemCount: iconList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 65,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (_, index) {
                                // list[index] = IconModel(list[index].iconName);
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color:
                                                  _selected == index ? Colors.grey : Colors.white,
                                              width: 1.5)),
                                      child: Image.asset(
                                        '${iconList[index].iconName}',
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _selected = index;
                                        iconName = iconList[index].iconName;
                                      });
                                    },
                                  ),
                                );
                              }),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  characterModel.weeklyContentList[i] =
                                      WeeklyContent(controller.text, iconName.toString(), true);
                                  Navigator.pop(context);
                                },
                                child: Text('확인'),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('취소')),
                            ],
                          )
                        ],
                      );
                    });
                  });
              setState(() {});
            },
          ),
          value: characterModel.weeklyContentList[i].isChecked,
          onChanged: (value) {
            setState(() {
              characterModel.weeklyContentList[i].isChecked = value!;
            });
          },
          contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        ),
      );
      weeklyCardList.add(card);
    }
    return Column(children: weeklyCardList);
  }

  Widget ticketContents() {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/etc/BossRush.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    PlatformWidget(
                      cupertino: (_, __) => Text(
                        '태양의 회랑',
                        style: contentStyle,
                      ),
                      material: (_, __) => Text(''),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => setState(() => num1 += 1),
                        icon: Icon(Icons.plus_one_outlined)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        '$num1',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () => setState(() => num1 > 0 ? num1 -= 1 : num1 = 0),
                        icon: Icon(Icons.exposure_minus_1_outlined)),
                  ],
                )
              ],
            ),
          ),
        ),
        Card(
          elevation: 2,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/etc/Cube.png',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    PlatformWidget(
                      cupertino: (_, __) => Text(
                        '디멘션 큐브',
                        style: contentStyle,
                      ),
                      material: (_, __) => Text(''),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () => setState(() => num2 += 1),
                        icon: Icon(Icons.plus_one_outlined)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        '$num2',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () => setState(() => num2 > 0 ? num2 -= 1 : num2 = 0),
                        icon: Icon(Icons.exposure_minus_1_outlined)),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
