import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constant.dart';

class DistributionCaluScreen extends StatefulWidget {
  const DistributionCaluScreen({Key? key}) : super(key: key);

  @override
  _DistributionCaluScreenState createState() => _DistributionCaluScreenState();
}

class _DistributionCaluScreenState extends State<DistributionCaluScreen> {
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
      body: Center(child: Text('준비 중'),),
    );
  }
}
