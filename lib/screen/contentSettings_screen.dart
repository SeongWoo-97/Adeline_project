import 'package:adeline_app/constant.dart';
import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:adeline_app/model/user/content/dailyContent.dart';
import 'package:adeline_app/model/user/content/restGaugeContent.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ContentSettingsScreen extends StatefulWidget {
  final charInfo;

  ContentSettingsScreen(this.charInfo);

  @override
  _ContentSettingsScreenState createState() => _ContentSettingsScreenState();
}

class _ContentSettingsScreenState extends State<ContentSettingsScreen> {
  int _selected = 0;
  String? iconName = iconList[0].iconName;
  int? chaos;
  int? guardian;
  int? epona;
  String? nickName;
  int? level;
  bool nickNameError = false;
  bool levelError = false;
  bool chaosError = false;
  bool guardianError = false;
  bool eponaError = false;
  late CharacterModel characterModel;
  final key = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  List<Card> dailyCardList = [];
  List<Card> weeklyCardList = [];
  TextEditingController controller = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController chaosGaugeController = TextEditingController();
  TextEditingController guardianGaugeController = TextEditingController();
  TextEditingController eponaGaugeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    characterModel = widget.charInfo;
    nickNameController = TextEditingController(text: characterModel.nickName);
    levelController = TextEditingController(text: characterModel.level);
    chaosGaugeController = TextEditingController(text: characterModel.dailyContentList[0].restGauge.toString());
    guardianGaugeController = TextEditingController(text: characterModel.dailyContentList[1].restGauge.toString());
    eponaGaugeController = TextEditingController(text: characterModel.dailyContentList[2].restGauge.toString());
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('콘텐츠 설정', style: contentStyle.copyWith(fontSize: 15, color: Colors.black)),
          leading: PlatformIconButton(
            material: (_, __) => MaterialIconButtonData(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
              onPressed: () async {
                if (nickNameError == true) {
                  nickNameErrorToast();
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                }
                if (levelError == true) {
                  levelErrorToast();
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                }
                if (chaosError == true || guardianError == true || eponaError == true) {
                  gaugeErrorToast();
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                }
                if (nickNameError == false &&
                    levelError == false &&
                    chaosError == false &&
                    guardianError == false &&
                    eponaError == false) {
                  formKey.currentState!.save();
                  formKey2.currentState!.save();
                  Navigator.pop(context, characterModel);
                }
              },
            ),
            cupertino: (_, __) => CupertinoIconButtonData(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () async {
                if (nickNameError == true) {
                  nickNameErrorToast();
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                }
                if (levelError == true) {
                  levelErrorToast();
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                }
                if (chaosError == true || guardianError == true || eponaError == true) {
                  gaugeErrorToast();
                  await Future.delayed(Duration(seconds: 1, milliseconds: 500));
                }
                if (nickNameError == false &&
                    levelError == false &&
                    chaosError == false &&
                    guardianError == false &&
                    eponaError == false) {
                  formKey.currentState!.save();
                  formKey2.currentState!.save();
                  Navigator.pop(context, characterModel);
                }
              },
            ),
          ),
          material: (_, __) => MaterialAppBarData(
            backgroundColor: Colors.white,
            elevation: .5,
            title: Text(
              '콘텐츠 설정',
              style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: PlatformWidgetBuilder(
                            cupertino: (_, child, __) => Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: PlatformTextFormField(
                                textAlign: TextAlign.center,
                                controller: nickNameController,
                                // iOS 수정필요
                                // decoration: BoxDecoration(
                                //   border: Border.all(color: nickNameError ? Colors.red : Colors.grey),
                                //   borderRadius: BorderRadius.circular(7),
                                // ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty || value.length >= 12) {
                                      nickNameError = true;
                                    } else {
                                      nickNameError = false;
                                    }
                                  });
                                },
                                onSaved: (value) {
                                  characterModel.nickName = value;
                                },
                              ),
                            ),
                            material: (_, child, __) => ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 35,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5, left: 5),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: nickNameController,
                                  decoration: InputDecoration(
                                    hintText: '닉네임',
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: nickNameError ? Colors.red : Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: nickNameError ? Colors.red : Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty || value.length >= 12) {
                                        nickNameError = true;
                                      } else {
                                        nickNameError = false;
                                      }
                                    });
                                  },
                                  onSaved: (value) {
                                    characterModel.nickName = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: PlatformWidgetBuilder(
                            cupertino: (_, child, __) => Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: PlatformTextFormField(
                                controller: levelController,
                                textAlign: TextAlign.center,
                                textInputAction: TextInputAction.done,
                                material: (_, __) => MaterialTextFormFieldData(
                                  decoration: InputDecoration(),
                                ),
                                cupertino: (_, __) => CupertinoTextFormFieldData(
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: BoxDecoration(
                                    border: Border.all(color: levelError ? Colors.red : Colors.grey),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  maxLength: 12,
                                  keyboardType: TextInputType.number,
                                ),
                                hintText: '아이템 레벨',
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty || value.length >= 5) {
                                      levelError = true;
                                    } else {
                                      levelError = false;
                                    }
                                  });
                                },
                                onSaved: (value) {
                                  characterModel.level = int.parse(value.toString()).toString();
                                },
                              ),
                            ),
                            material: (_, child, __) => ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 35,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5, left: 5),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: levelController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                    hintText: '아이템 레벨',
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: levelError ? Colors.red : Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: levelError ? Colors.red : Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty || value.length >= 5) {
                                        levelError = true;
                                      } else {
                                        levelError = false;
                                      }
                                    });
                                  },
                                  onSaved: (value) {
                                    characterModel.level = int.parse(value.toString()).toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: formKey2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5,bottom: 5),
                          child: Text(
                            '휴식게이지',
                            style: TextStyle(fontSize: 18, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                          child: Image.asset('assets/daily/Chaos.png', width: 30, height: 30),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: PlatformWidgetBuilder(
                                              cupertino: (_, child, __) => PlatformTextFormField(
                                                controller: chaosGaugeController,
                                                textAlign: TextAlign.center,
                                                cupertino: (_, __) => CupertinoTextFormFieldData(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: chaosError ? Colors.red : Colors.grey),
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                onSaved: (value) {
                                                  characterModel.dailyContentList[0].restGauge = int.parse(value.toString());
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      chaosError = true;
                                                    } else {
                                                      chaosError = false;
                                                    }
                                                  });
                                                },
                                              ),
                                              material: (_, child, __) => ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: 45,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                                  child: TextFormField(
                                                    controller: chaosGaugeController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(color: chaosError ? Colors.red : Colors.grey, width: 0.5),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(color: chaosError ? Colors.red : Colors.grey, width: 0.5),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                    onSaved: (value) {
                                                      characterModel.dailyContentList[0].restGauge = int.parse(value.toString());
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (value.length == 0 ||
                                                            int.parse(value.toString()) % 10 != 0 ||
                                                            int.parse(value.toString()) < 0 ||
                                                            int.parse(value.toString()) > 100) {
                                                          chaosError = true;
                                                        } else {
                                                          chaosError = false;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text('클리어 횟수',style: contentStyle,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            child: Image.asset(
                                              'assets/etc/math_minus.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            onTap: () {
                                              if (characterModel.dailyContentList[0].clearNum > 0) {
                                                characterModel.dailyContentList[0].clearNum -= 1;
                                                setState(() {});
                                              } else {
                                                toast('최소 클리어 횟수는 0입니다.');
                                              }
                                            },
                                          ),
                                          Text(
                                            '${characterModel.dailyContentList[0].clearNum}',
                                            style: contentStyle.copyWith(fontSize: 18),
                                          ),
                                          InkWell(
                                            child: Image.asset(
                                              'assets/etc/math_plus.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            onTap: () {
                                              if (characterModel.dailyContentList[0].clearNum <
                                                  characterModel.dailyContentList[0].maxClearNum) {
                                                characterModel.dailyContentList[0].clearNum += 1;
                                                setState(() {});
                                              } else {
                                                toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                          child: Image.asset('assets/daily/Guardian.png', width: 30, height: 30),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: PlatformWidgetBuilder(
                                              cupertino: (_, child, __) => PlatformTextFormField(
                                                controller: guardianGaugeController,
                                                textAlign: TextAlign.center,
                                                cupertino: (_, __) => CupertinoTextFormFieldData(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: guardianError ? Colors.red : Colors.grey),
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                onSaved: (value) {
                                                  characterModel.dailyContentList[1].restGauge = int.parse(value.toString());
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      guardianError = true;
                                                    } else {
                                                      guardianError = false;
                                                    }
                                                  });
                                                },
                                              ),
                                              material: (_, child, __) => ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: 45,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                                  child: TextFormField(
                                                    controller: guardianGaugeController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide(color: guardianError ? Colors.red : Colors.grey, width: 0.5),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                        BorderSide(color: guardianError ? Colors.red : Colors.grey, width: 0.5),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                    onSaved: (value) {
                                                      characterModel.dailyContentList[1].restGauge = int.parse(value.toString());
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (value.length == 0 ||
                                                            int.parse(value.toString()) % 10 != 0 ||
                                                            int.parse(value.toString()) < 0 ||
                                                            int.parse(value.toString()) > 100) {
                                                          guardianError = true;
                                                        } else {
                                                          guardianError = false;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text('클리어 횟수',style: contentStyle,),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            child: Image.asset(
                                              'assets/etc/math_minus.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            onTap: () {
                                              if (characterModel.dailyContentList[1].clearNum > 0) {
                                                characterModel.dailyContentList[1].clearNum -= 1;
                                                setState(() {});
                                              } else {
                                                toast('최소 클리어 횟수는 0입니다.');
                                              }
                                            },
                                          ),
                                          Text(
                                            '${characterModel.dailyContentList[1].clearNum}',
                                            style: contentStyle.copyWith(fontSize: 18),
                                          ),
                                          InkWell(
                                            child: Image.asset(
                                              'assets/etc/math_plus.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            onTap: () {
                                              if (characterModel.dailyContentList[1].clearNum <
                                                  characterModel.dailyContentList[1].maxClearNum) {
                                                characterModel.dailyContentList[1].clearNum += 1;
                                                setState(() {});
                                              } else {
                                                toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                          child: Image.asset('assets/daily/Epona.png', width: 30, height: 30),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: PlatformWidgetBuilder(
                                              cupertino: (_, child, __) => PlatformTextFormField(
                                                controller: eponaGaugeController,
                                                textAlign: TextAlign.center,
                                                cupertino: (_, __) => CupertinoTextFormFieldData(
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: eponaError ? Colors.red : Colors.grey),
                                                    borderRadius: BorderRadius.circular(7),
                                                  ),
                                                ),
                                                onSaved: (value) {
                                                  characterModel.dailyContentList[2].restGauge = int.parse(value.toString());
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    if (value.length == 0 ||
                                                        int.parse(value.toString()) % 10 != 0 ||
                                                        int.parse(value.toString()) < 0 ||
                                                        int.parse(value.toString()) > 100) {
                                                      eponaError = true;
                                                    } else {
                                                      eponaError = false;
                                                    }
                                                  });
                                                },
                                              ),
                                              material: (_, child, __) => ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxHeight: 45,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                                                  child: TextFormField(
                                                    controller: eponaGaugeController,
                                                    textAlign: TextAlign.center,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.zero,
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(color: eponaError ? Colors.red : Colors.grey, width: 0.5),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide(color: eponaError ? Colors.red : Colors.grey, width: 0.5),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                    ),
                                                    onSaved: (value) {
                                                      characterModel.dailyContentList[2].restGauge = int.parse(value.toString());
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (value.length == 0 ||
                                                            int.parse(value.toString()) % 10 != 0 ||
                                                            int.parse(value.toString()) < 0 ||
                                                            int.parse(value.toString()) > 100) {
                                                          eponaError = true;
                                                        } else {
                                                          eponaError = false;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text('클리어 횟수',style: contentStyle,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            child: Image.asset(
                                              'assets/etc/math_minus.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            onTap: () {
                                              if (characterModel.dailyContentList[2].clearNum > 0) {
                                                characterModel.dailyContentList[2].clearNum -= 1;
                                                setState(() {});
                                              } else {
                                                toast('최소 클리어 횟수는 0입니다.');
                                              }
                                            },
                                          ),
                                          Text(
                                            '${characterModel.dailyContentList[2].clearNum}',
                                            style: contentStyle.copyWith(fontSize: 18),
                                          ),
                                          InkWell(
                                            child: Image.asset(
                                              'assets/etc/math_plus.png',
                                              width: 25,
                                              height: 25,
                                            ),
                                            onTap: () {
                                              if (characterModel.dailyContentList[2].clearNum <
                                                  characterModel.dailyContentList[2].maxClearNum) {
                                                characterModel.dailyContentList[2].clearNum += 1;
                                                setState(() {});
                                              } else {
                                                toast('최대 클리어 횟수를 초과할 수 없습니다.');
                                              }
                                            },
                                          )
                                        ],
                                      ),
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  '일일 콘텐츠',
                                  style: TextStyle(fontSize: 18, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ),
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
                                                                color: _selected == index ? Colors.grey : Colors.white,
                                                                width: 1.5),
                                                          ),
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
                                                          DailyContent(controller.text.toString(), iconName.toString(), true));
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
                              )
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: dailyContents(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 0, 5, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Text(
                                  '주간 콘텐츠',
                                  style: TextStyle(fontSize: 18, fontFamily: 'NotoSansKR', fontWeight: FontWeight.w300),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ),
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
                                                                  color: _selected == index ? Colors.grey : Colors.white,
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
                                                          WeeklyContent(controller.text.toString(), iconName.toString(), true));
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
                              )
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: weeklyContents(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                /// 태양의 회랑 및 디멘션 큐브 티켓 갯수 추후 추가예정
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
                //                 '기타 콘텐츠',
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
  List<Widget> dailyContents() {
    dailyCardList = [];
    // 공통변수 - 이름, 아이콘이름,
    for (int i = 0; i < characterModel.dailyContentList.length; i++) {
      Card card = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(color: Colors.grey, width: 0.8),
        ),
        child: CheckboxListTile(
          title: Row(
            children: [
              Row(
                children: [
                  characterModel.dailyContentList[i] is DailyContent
                      ? InkWell(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Image.asset(
                              'assets/etc/Minus.png',
                              width: 25,
                              height: 25,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            characterModel.dailyContentList.removeAt(i);
                            setState(() {});
                            toast('삭제가 완료되었습니다.');
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: InkWell(
                            child: Image.asset(
                              'assets/etc/Minus.png',
                              width: 25,
                              height: 25,
                              color: Colors.red,
                            ),
                            onTap: () {
                              toast('해당 콘텐츠는 삭제할 수 없습니다.');
                            },
                          ),
                        ),
                ],
              ),
              Flexible(
                child: InkWell(
                  child: PlatformWidget(
                    cupertino: (_, __) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            characterModel.dailyContentList[i].iconName,
                            width: 25,
                            height: 25,
                          ),
                        ),
                        Text(
                          characterModel.dailyContentList[i].name,
                          style: contentStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    material: (_, __) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            characterModel.dailyContentList[i].iconName,
                            width: 25,
                            height: 25,
                          ),
                        ),
                        Text(
                          characterModel.dailyContentList[i].name,
                          style: contentStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    controller.text = '${characterModel.dailyContentList[i].name}';
                    characterModel.dailyContentList[i] is RestGaugeContent
                        ? toast('고정 콘텐츠는 수정할 수 없습니다.')
                        : await showDialog(
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
                                                        color: _selected == index ? Colors.grey : Colors.white, width: 1.5)),
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
              ),
            ],
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
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
        ),
      );
      dailyCardList.add(card);
    }
    return dailyCardList;
  }

  List<Widget> weeklyContents() {
    weeklyCardList = [];
    for (int i = 0; i < characterModel.weeklyContentList.length; i++) {
      Card card = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(color: Colors.grey, width: 0.8),
        ),
        child: CheckboxListTile(
          title: Row(
            children: [
              Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Image.asset(
                        'assets/etc/Minus.png',
                        width: 25,
                        height: 25,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      characterModel.weeklyContentList.removeAt(i);
                      setState(() {});
                      toast('삭제가 완료되었습니다.');
                    },
                  )
                ],
              ),
              Flexible(
                child: InkWell(
                  child: PlatformWidget(
                    cupertino: (_, __) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            characterModel.weeklyContentList[i].iconName,
                            width: 25,
                            height: 25,
                          ),
                        ),
                        Text(
                          characterModel.weeklyContentList[i].name,
                          style: contentStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    material: (_, __) => Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: Image.asset(
                            characterModel.weeklyContentList[i].iconName,
                            width: 25,
                            height: 25,
                          ),
                        ),
                        Text(
                          characterModel.weeklyContentList[i].name,
                          style: contentStyle.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  onTap: () async {
                    controller.text = '${characterModel.weeklyContentList[i].name}';
                    characterModel.weeklyContentList[i] is RestGaugeContent
                        ? toast('고정 콘텐츠는 수정할 수 없습니다.')
                        : await showDialog(
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
                                                    borderRadius: BorderRadius.circular(7),
                                                    border: Border.all(
                                                        color: _selected == index ? Colors.grey : Colors.white, width: 1.5)),
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
              ),
            ],
          ),

          /// _isChecked 를 characterModel -> dailyContent 에서 가져오기
          /// model 에 _isChecked bool 형태로 추가하기
          value: characterModel.weeklyContentList[i].isChecked,
          onChanged: (value) {
            setState(() {
              characterModel.weeklyContentList[i].isChecked = value!;
            });
          },
          // CheckBoxTile 위아래 padding 삭제
          contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
        ),
      );
      weeklyCardList.add(card);
    }
    return weeklyCardList;
  }
  
  String levelText(String level) {
    int start = level.indexOf('.') + 1;
    int end = level.lastIndexOf('.');
    return 'Lv.' + level.substring(start, end);
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

  void nickNameErrorToast() {
    Fluttertoast.showToast(
      msg: "닉네임이 잘못 설정되었습니다.",
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }

  void levelErrorToast() {
    Fluttertoast.showToast(
      msg: "아이템 레벨 값이 잘못 설정되었습니다.",
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }

  void gaugeErrorToast() {
    Fluttertoast.showToast(
      msg: "휴식 게이지 값이 잘못되었습니다.",
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }
}
