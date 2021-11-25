import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'model/continent/continentModel.dart';
import 'model/iconModel.dart';

TextStyle titleStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

TextStyle contentStyle = TextStyle(fontFamily: 'SpoqaHanSansNeo');

TextStyle androidContentStyle = TextStyle(fontFamily: 'NotoSansKR');

List<IconModel> iconList = [
  IconModel('assets/daily/Chaos.png'),
  IconModel('assets/daily/Guardian.png'),
  IconModel('assets/daily/Epona.png'),
  IconModel('assets/week/WeeklyEpona.png'),
  IconModel('assets/week/AbyssDungeon.png'),
  IconModel('assets/expedition/ChallengeAbyss.png'),
  IconModel('assets/week/AbyssRaid.png'),
  IconModel('assets/week/Crops.png'),
  IconModel('assets/expedition/ChaosGate.png'),
  IconModel('assets/expedition/GhostShip.png'),
  IconModel('assets/expedition/Rehearsal.png'),
  IconModel('assets/expedition/Dejavu.png'),
  IconModel('assets/etc/GuildCoin.png'),
  IconModel('assets/etc/PirateCoin.png'),
  IconModel('assets/etc/QuestNormal.png'),
  IconModel('assets/etc/SubjugationBattle.png'),
  IconModel('assets/expedition/ExpeditionFarm.png'),
  IconModel('assets/expedition/LifeEnergy.png'),
  IconModel('assets/expedition/LikeAbility.png'),
  IconModel('assets/expedition/PlatinumField.png'),
  IconModel('assets/etc/Cube.png'),
  IconModel('assets/etc/BossRush.png'),
  IconModel('assets/etc/Ticket.png'),
];

List<Continent> secretMaps = [
  Continent('아르테미스', ['로그힐', '안게모스 산 기슭', '국경지대']),
  Continent('유디아', ['살란드 구릉지', '오즈혼 구릉지']),
  Continent('루테란 서부', ['자고라스 산', '레이크바', '메드리닉 수도원', '빌브린 숲', '격전의 평야']),
  Continent('루테란 동부', ['디오리카 평원', '해무리 언덕', '배꽃나무 자생지', '흑장미 교회당', '라니아 단구', '보레아 영지', '크로커니스 해변']),
  Continent('토토이크', ['바다향기 숲', '달콤한 숲', '섬큼바위 숲', '침묵하는 거인의 숲']),
  Continent('애니츠', ['델파이 현', '등나무 언덕', '소리의 숲', '거울 계곡', '황혼의 연무']),
  Continent('아르데타인', ['메마른 통로', '갈라진 땅', '네벨호른', '바람결 구릉지', '토트리치', '리제 폭포']),
  Continent('베른 북부', ['크로나 항구', '파르나 숲', '페스나르 고원', '베르닐 삼림', '발란카르 산맥']),
  Continent('슈샤이어', ['얼어붙은 바다', '칼날바람 언덕', '머무른 시간의 호수', '얼음나비 절벽']),
  Continent('로헨델', ['은빛물결 호수', '유리연꽃 호수', '바람향기 언덕', '파괴된 제나일', '엘조윈의 그늘']),
  Continent('욘', ['시작의 땅', '미완의 정원', '검은모루 작업장', '무쇠망치 작업장', '기약의 땅']),
  Continent('페이튼', ['칼라자 마을']),
  Continent('파푸니카', ['얕은 바닷길', '별모래 해변', '티카티카 군락지', '비밀의 숲']),
  Continent('베른 남부', ['칸다리아 영지', '벨리온 유적지']),
];

// 전 대륙 전 지역 백업본
// Continent('아르테미스', ['레온하트', '로그힐', '안게모스 산 기슭', '국경지대']),
// Continent('유디아', ['살란드 구릉지', '오즈혼 구릉지']),
// Continent('루테란 서부', ['자고라스 산', '레이크바', '메드리닉 수도원', '빌브린 숲', '격전의 평야']),
// Continent('루테란 동부', ['루테란 성', '디오리카 평원', '해무리 언덕', '배꽃나무 자생지', '흑장미 교회당', '라니아 단구', '보레아 영지', '갈기파도 항구', '크로커니스 해변']),
// Continent('토토이크', ['바다향기 숲', '모코코 마을', '달콤한 숲', '섬큼바위 숲', '침묵하는 거인의 숲']),
// Continent('애니츠', ['항구도시 창천', '델파이 현', '등나무 언덕', '소리의 숲', '거울 계곡', '황혼의 연무']),
// Continent('아르데타인', ['메마른 통로', '슈테른', '갈라진 땅', '네벨호른', '바람결 구릉지', '토트리치', '붉은 모래 사막', '리제 폭포']),
// Continent('베른 북부', ['크로나 항구', '베른 성', '라니아 마을', '파르나 숲', '페스나르 고원', '베르닐 삼림', '발란카르 산맥']),
// Continent('슈샤이어', ['얼어붙은 바다', '리겐스 마을', '칼날바람 언덕', '머무른 시간의 호수', '얼음나비 절벽']),
// Continent('로헨델', ['은빛물결 호수', '로아룬', '유리연꽃 호수', '바람향기 언덕', '파괴된 제나일', '엘조윈의 그늘']),
// Continent('욘', ['시작의 땅', '위대한 성', '미완의 정원', '검은모루 작업장', '무쇠망치 작업장', '기약의 땅']),
// Continent('페이튼', ['이름 없는 협곡', '칼라자 마을', '울부짖는 늪지대', '그늘진 절벽', '붉은 달의 흔적']),
// Continent('파푸니카', ['얕은 바닷길', '니아 마을', '별모래 해변', '티카티카 군락지', '비밀의 숲']),
// Continent('베른 남부', ['칸다리아 영지', '벨리온 유적지']),
