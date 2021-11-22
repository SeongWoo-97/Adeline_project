import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constant.dart';

class MerchantLocationScreen extends StatefulWidget {
  const MerchantLocationScreen({Key? key}) : super(key: key);

  @override
  _MerchantLocationScreenState createState() => _MerchantLocationScreenState();
}

class _MerchantLocationScreenState extends State<MerchantLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('떠돌이 상인 위치', style: contentStyle.copyWith(fontSize: 15, color: Colors.black)),
        material: (_, __) => MaterialAppBarData(
          backgroundColor: Colors.white,
          elevation: .5,
          title: Text(
            '떠돌이 상인 위치',
            style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(child: Text('준비 중'),),
    );
  }
}
