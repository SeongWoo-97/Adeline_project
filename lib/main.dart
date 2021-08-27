import 'package:adeline_app/screen/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialTheme = ThemeData(
      cupertinoOverrideTheme: CupertinoThemeData(
          // primaryColor: Color(0xff127EFB),
          ),
      // primarySwatch: Colors.green,
      // outlinedButtonTheme: OutlinedButtonThemeData(
      //   style: ButtonStyle(
      //     padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
      //     foregroundColor: MaterialStateProperty.all(Color(0xFF3DDC84)),
      //   ),
      // ),
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
          title: 'Flutter Platform Widgets',
          home: LoadingScreen(),
          material: (_, __) => MaterialAppData(
            theme: materialTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
                // primaryColor: Color(0xff127EFB),
                textTheme: CupertinoTextThemeData()),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
