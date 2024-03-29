import 'package:adeline_app/screen/Binpago_WebView.dart';
import 'package:adeline_app/screen/Distribution_calu_Screen.dart';
import 'package:adeline_app/screen/Merchant_Location_Screen.dart';
import 'package:adeline_app/screen/detail_screen.dart';
import 'package:adeline_app/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../constant.dart';



class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 2);
  List<Widget> screens = [
    DistributionCaluScreen(),
    MerchantLocationScreen(),
    HomeScreen(),
    BinpagoWebView(),
    DetailScreen(),
  ];
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calculate_outlined),
        title: ("분배금 계산기"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.map),
        title: ("떠돌이 상인 위치"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home,color: Colors.white,),
        title: ("메인화면"),
        activeColorPrimary: CupertinoColors.systemTeal,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        textStyle: contentStyle.copyWith(color: Colors.black,)
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.web),
        title: ("빙고 도우미"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu),
        title: ("더보기"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(5.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 400),
      ),
      navBarStyle: NavBarStyle.style17, // Choose the nav bar style with this property.
    );
  }
}
