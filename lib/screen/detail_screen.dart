import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constant.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(
          backgroundColor: Colors.white,
          elevation: .5,
          title: Text(
            '로스트아크 아델라인',
            style: contentStyle.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ExpansionTile(
                  title: Text('도움을 주신분들께'),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('안녕하세요! 아델라인 개발자입니다.\n많은 의견을 제시해주신분들께 너무나도 감사드립니다. \n이번 업데이트를 통해 아래와 같은 사항들이 개선및 추가되었습니다.'),
                          Text('\n- 콘텐츠 설정 페이지 일일/주간 UI 변경'),
                          Text('- 콘텐츠 순서 변경할 수 있도록 개선'),
                          Text('- 캐릭터 슬롯창 UI 변경'),
                          Text('- 아이콘 및 폰트 크기 수정'),
                          Text('- 일일/주간 콘텐츠 완료 시 슬롯창 색깔 변경'),
                          Text('- 데자뷰아이콘 변경'),
                          Text('- 하단 메뉴바 레이아웃 변경'),
                          Text('- 빙고 도우미(빙파고) WebView 추가'),
                          Text('\n 개선 및 추가해야 될 사항\n'),
                          Text('- 주간 콘텐츠 클리어 기준 개선'),
                          Text('- 물리버튼으로 뒤로가기 개선'),
                          Text('- 캐릭터 레벨 최신화 기능 추가'),
                          Text('- 세분화된 콘텐츠 기능 추가'),
                          Text('- 프로키온 나침반 추가'),
                          Text('- 메모 기능 추가'),
                          Text('\n취업을 준비해야 될 시기이기 때문에 빠른 시일 내에 업데이트를 약속드리지는 못하겠지만 틈틈이 업데이트하도록 노력해 보겠습니다.')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ExpansionTile(
                  title: Text('출처'),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('아이콘 출처\n - https://lostark.game.onstove.com/\n'),
                          Text('떠돌이 상인지도 출처\n - https://lostark.inven.co.kr/\n'),
                          Text('떠돌이 상인 이미지 수정\n - https://blog.naver.com/lovelycoconut/222468022028\n'),
                          Text('빙파고\n - https://github.com/ialy1595/kouku-saton-bingo'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
