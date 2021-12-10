import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constant.dart';

class DistributionCaluScreen extends StatefulWidget {
  const DistributionCaluScreen({Key? key}) : super(key: key);

  @override
  _DistributionCaluScreenState createState() => _DistributionCaluScreenState();
}

class _DistributionCaluScreenState extends State<DistributionCaluScreen> {
  bool fourMembers = false;
  bool eightMembers = false;
  int distributionValue1 = 0;
  int distributionValue2 = 0;
  int getGold = 0;
  double? memberNum = 4;
  final key = GlobalKey<FormState>();
  TextEditingController itemPriceController = TextEditingController(text: '0');
  BannerAd bannerAd = BannerAd(
    adUnitId: 'ca-app-pub-2659418845004468/1781199037',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('분배금 계산기', style: contentStyle.copyWith(fontSize: 15, color: Colors.black)),
          material: (_, __) => MaterialAppBarData(
            backgroundColor: Colors.white,
            elevation: .5,
            title: Text(
              '분배금 계산기',
              style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomRadioButton(
                      buttonLables: ['4인', '8인'],
                      buttonValues: [4, 8],
                      radioButtonValue: (values) {
                        toast('$values인 선택');
                        bidPrice(itemPriceController.text, double.parse(values.toString()));
                      },
                      elevation: 0,
                      defaultSelected: 4,
                      buttonTextStyle: ButtonTextStyle(
                        textStyle: contentStyle,
                        selectedColor: Colors.black,
                        unSelectedColor: Colors.blue,
                      ),
                      unSelectedColor: Colors.transparent,
                      unSelectedBorderColor: Colors.grey,
                      selectedBorderColor: Colors.indigo,
                      selectedColor: Colors.black26,
                      width: MediaQuery.of(context).size.width * 0.453,
                      absoluteZeroSpacing: false,
                      customShape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey)),
                      enableShape: true,
                    ),
                  )
                ],
              ),
              PlatformWidgetBuilder(
                cupertino: (_, child, __) => Padding(
                  padding: const EdgeInsets.fromLTRB(9, 0, 10, 0),
                  child: Form(
                    key: key,
                    child: PlatformTextFormField(
                      controller: itemPriceController,
                      textAlign: TextAlign.center,
                      cupertino: (_, __) => CupertinoTextFormFieldData(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onChanged: (value) {
                        if (memberNum != null) {
                            bidPrice(value, memberNum!);
                        }
                      },
                      onSaved: (value) {
                        if (memberNum != null) {
                          if(value != null){
                            bidPrice(value, memberNum!);
                          }
                        }
                      },
                    ),
                  ),
                ),
                material: (_, child, __) => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 45,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                    child: TextFormField(
                      controller: itemPriceController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onChanged: (value) {
                        if (memberNum != null) {
                          bidPrice(value, memberNum!);
                        }
                      },
                      onSaved: (value) {
                        if (memberNum != null) {
                          if(value != null){
                            bidPrice(value, memberNum!);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    '선점 입찰 적정가',
                                    style: contentStyle.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('$distributionValue1'),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    '파티 전체 균등분배',
                                    style: contentStyle.copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('$distributionValue2'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '선점 입찰 성공시 ',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                    '${(int.parse(itemPriceController.text) - distributionValue1 - (int.parse(itemPriceController.text) * 0.05)).round()}',
                                    style: TextStyle(color: Colors.green, decoration: TextDecoration.underline, fontSize: 16),
                                  ),
                                  TextSpan(text: ' 골드 이득'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) => Container(
                  child: AdWidget(ad: bannerAd),
                  width: bannerAd.size.width.toDouble(),
                  height: 60.0,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ));
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

  void bidPrice(String price, double memberNum) {
    setState(() {
      int num = (int.parse(price).toDouble() * 0.95 * ((memberNum - 1) / memberNum)).round();
      distributionValue1 = (num / 1.1).round();
      distributionValue2 = num;
    });
  }
}
