import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ContentSettingsScreen extends StatefulWidget {
  const ContentSettingsScreen({Key? key}) : super(key: key);

  @override
  _ContentSettingsScreenState createState() => _ContentSettingsScreenState();
}

class _ContentSettingsScreenState extends State<ContentSettingsScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('컨텐츠 설정'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Expanded(child: dailyContents()),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Positioned(
                        left: 50,
                        top: 11,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          color: Colors.white,
                          child: Text(
                            '일일 컨텐츠',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        )),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 485,
                      child: cropsContents(),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Positioned(
                        left: 50,
                        top: 11,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                          color: Colors.white,
                          child: Text(
                            '주간 컨텐츠',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget dailyContents() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/daily/Chaos.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('카오스 던전')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/daily/Guardian.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('가디언 토벌')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/daily/Epona.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('에포나 의뢰')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
      ],
    );
  }

  Widget cropsContents() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
          elevation: 3,
          child: CheckboxListTile(
            title: Row(
              children: [
                Image.asset(
                  'assets/week/AbyssDungeon.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('오레하의 우물')
              ],
            ),
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/week/AbyssRaid.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('아르고스')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/daily/Guardian.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('도전가디언 토벌')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          elevation: 3,
          child: CheckboxListTile(
            title: Row(
              children: [
                Image.asset(
                  'assets/week/Crops.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Text('발탄')
              ],
            ),
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/week/Crops.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('비아키스')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/week/Crops.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('쿠크세이튼')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
        Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          elevation: 3,
          child: CheckboxListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/week/Crops.png',
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('아브렐슈드')
                ],
              ),
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              }),
        ),
      ],
    );
  }
}
