import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class InitSettingsScreen extends StatefulWidget {
  @override
  _InitSettingsScreenState createState() => _InitSettingsScreenState();
}

class _InitSettingsScreenState extends State<InitSettingsScreen> {
  int _currentStep = 0;
  TextEditingController textEditingController = TextEditingController();
  // 공백제거, 특수문자 금지 또는 검색시 반환값을 보고 결과 여부 출력
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('초기설정'),
        ),
        body: SafeArea(
          child: Stepper(
            type: StepperType.horizontal,
            physics: ScrollPhysics(),
            currentStep: _currentStep,
            onStepTapped: (step) => tapped(step),
            steps: <Step>[
              Step(
                title: Text('대표 캐릭터'),
                content: stepOne(),
                isActive: _currentStep >= 0,
                state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text('캐릭터 순서'),
                content: stepTwo(),
                isActive: _currentStep >= 0,
                state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: Text('화면 설정'),
                content: stepThree(),
                isActive: _currentStep >= 0,
                state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
            ],
            controlsBuilder: (BuildContext context,
                {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              return Container();
            },
          ),
        ));
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  Widget stepOne() {
    return Column(
      children: [
        Column(
          children: [
            Text('본 캐릭터의 닉네임을 입력해주시길 바랍니다.'),
            Text('대표 캐릭터는 메인화면 상단에 고정 됩니다.'),
          ],
        ),
        PlatformWidgetBuilder(
          cupertino: (_,child, __) => CupertinoTextField(
            textAlign: TextAlign.center,
            controller: textEditingController,
          ),
          material: (_,child, __) => TextField(
            textAlign: TextAlign.center,
            controller: textEditingController,
          ),
        ),
        PlatformElevatedButton(
          child: Text('캐릭터 정보확인'),
          onPressed: (){
            // AlertDialog 확인유무 체크후 캐릭터 불러온후 다음단계로 이동
          },
        )
      ],
    );
  }

  Widget stepTwo() {
    return Container();
  }

  Widget stepThree() {
    return Container();
  }
}
