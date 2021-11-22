import 'package:adeline_app/model/user/content/restGaugeContent.dart';
import 'package:adeline_app/model/user/content/weeklyContent.dart';
import 'package:adeline_app/model/user/expeditionModel.dart';
import 'package:adeline_app/screen/MainMenu.dart';
import 'package:adeline_app/screen/home_screen.dart';
import 'package:adeline_app/screen/initSettings_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/user/characterModel/characterModel.dart';
import 'model/user/content/dailyContent.dart';
import 'model/user/user.dart';

bool dbCheck = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  Hive.registerAdapter(DailyContentAdapter());
  Hive.registerAdapter(WeeklyContentAdapter());
  Hive.registerAdapter(ExpeditionModelAdapter());
  Hive.registerAdapter(RestGaugeContentAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('localDB');
  // 참 : 메인화면 , 거짓 : 초기설정
  Hive.box<User>('localDB').get('user') != null ? dbCheck = true : dbCheck = false;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final materialTheme = ThemeData(
      cupertinoOverrideTheme: CupertinoThemeData(),
    );

    return Theme(
      data: materialTheme,
      child: PlatformProvider(
        settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
        builder: (context) => PlatformApp(
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          title: 'Adeline',
          home: dbCheck ? MainMenu() : InitSettingsScreen(),
          material: (_, __) => MaterialAppData(
            theme: materialTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
                // primaryColor: Color(0xff127EFB),
                ),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
