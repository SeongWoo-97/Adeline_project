import 'package:adeline_app/constant.dart';
import 'package:adeline_app/screen/initSettings_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => InitSettingsScreen()), (route) => false);
    });
    // localDB 여부 확인후 initSettings 또는 HomeScreen 으로 이동
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                PlatformText('LOST ARK', style: titleStyle),
                PlatformText('ADELINE PROJECT', style: titleStyle)
              ],
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
