import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/rendering.dart';

import '../constant.dart';

class MerchantLocationScreen extends StatefulWidget {
  const MerchantLocationScreen({Key? key}) : super(key: key);

  @override
  _MerchantLocationScreenState createState() => _MerchantLocationScreenState();
}

class _MerchantLocationScreenState extends State<MerchantLocationScreen> {
  final TextEditingController _typeAheadController = TextEditingController();
  SuggestionsBoxController _suggestionsBoxController = SuggestionsBoxController();
  CupertinoSuggestionsBoxController _cupertinoSuggestionsBoxController = CupertinoSuggestionsBoxController();
  late List<DropdownMenuItem> _dropdownTestItems;
  List<String> regions = [];
  String selectedItem = '';
  late int selectedContinent;
  late int selectedRegion;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  RelativeRect a(popupButtonObject, overlay) {
    final decorationBox = _findBorderBox(popupButtonObject);

    double translateOffset = 0;
    if (decorationBox != null) {
      translateOffset = decorationBox.size.height - popupButtonObject.size.height;
    }

    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
    return RelativeRect.fromSize(
      Rect.fromPoints(
        popupButtonObject
            .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
            .translate(0, translateOffset),
        popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Size(overlay.size.width, overlay.size.height),
    );
  }

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
      cupertino: (_, __) => CupertinoPageScaffoldData(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoTypeAheadField(
                            getImmediateSuggestions: true,
                            textFieldConfiguration: CupertinoTextFieldConfiguration(
                              controller: _typeAheadController,
                              prefix: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                                child: Icon(Icons.search),
                              ),
                            ),
                            suggestionsCallback: (String pattern) {
                              return StateService.getSuggestions(pattern);
                            },
                            onSuggestionSelected: (String suggestion) {
                              _typeAheadController.text = suggestion;
                              // 사진변경 코드 추가
                            },
                            // suggestionsBoxDecoration: CupertinoSuggestionsBoxDecoration(
                            //   constraints: BoxConstraints(maxHeight: 100),
                            // ),
                            suggestionsBoxController: _cupertinoSuggestionsBoxController,
                            itemBuilder: (BuildContext context, String suggestion) {
                              return Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(suggestion),
                              );
                            },
                            minCharsForSuggestions: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<String>(
                            validator: (v) => v == null ? "required field" : null,
                            dropdownSearchDecoration: InputDecoration(
                              label: Text('대륙 선택'),
                              contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            mode: Mode.MENU,
                            selectedItem: '',
                            showSelectedItems: true,
                            items: List.generate(secretMaps.length, (index) => secretMaps[index].continentName.toString()),
                            onChanged: (value) {
                              for (int i = 0; i < secretMaps.length; i++) {
                                if (secretMaps[i].continentName.toString() == value) {
                                  setState(() {
                                    regions = secretMaps[i].areaNames!;
                                    selectedContinent = i;
                                  });
                                }
                              }
                            },
                            positionCallback: (popupButtonObject, overlay) {
                              final decorationBox = _findBorderBox(popupButtonObject);

                              double translateOffset = 0;
                              if (decorationBox != null) {
                                translateOffset = decorationBox.size.height - popupButtonObject.size.height;
                              }

                              final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                              return RelativeRect.fromSize(
                                Rect.fromPoints(
                                  popupButtonObject
                                      .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
                                      .translate(0, translateOffset),
                                  popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero),
                                      ancestor: overlay),
                                ),
                                Size(overlay.size.width, overlay.size.height),
                              );
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<String>(
                            validator: (v) => v == null ? "required field" : null,
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "지역 선택",
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            mode: Mode.MENU,
                            showSelectedItems: true,
                            items: regions,
                            selectedItem: selectedItem,
                            onChanged: print,
                            positionCallback: (popupButtonObject, overlay) {
                              final decorationBox = _findBorderBox(popupButtonObject);

                              double translateOffset = 0;
                              if (decorationBox != null) {
                                translateOffset = decorationBox.size.height - popupButtonObject.size.height;
                              }

                              final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                              return RelativeRect.fromSize(
                                Rect.fromPoints(
                                  popupButtonObject
                                      .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
                                      .translate(0, translateOffset),
                                  popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero),
                                      ancestor: overlay),
                                ),
                                Size(overlay.size.width, overlay.size.height),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ClipRect(
                      child: PhotoView.customChild(
                        backgroundDecoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(
                          "assets/map/test1.png",
                        ),
                        initialScale: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      material: (_, __) => MaterialScaffoldData(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TypeAheadField(
                          getImmediateSuggestions: true,
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: _typeAheadController,
                              decoration: InputDecoration(
                                // border: InputDecorator(decoration: Dec,),
                                label: Text('Search'),
                                icon: Icon(Icons.search)
                              )),
                          suggestionsCallback: (String pattern) {
                            return StateService.getSuggestions(pattern);
                          },
                          onSuggestionSelected: (String suggestion) {
                            _typeAheadController.text = suggestion;
                            // 사진변경 코드 추가
                          },
                          suggestionsBoxController: _suggestionsBoxController,
                          itemBuilder: (BuildContext context, String suggestion) {
                            return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(suggestion),
                            );
                          },
                          minCharsForSuggestions: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,
                          dropdownSearchDecoration: InputDecoration(
                            label: Text('대륙 선택'),
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          mode: Mode.MENU,
                          selectedItem: '',
                          showSelectedItems: true,
                          items: List.generate(secretMaps.length, (index) => secretMaps[index].continentName.toString()),
                          onChanged: (value) {
                            for (int i = 0; i < secretMaps.length; i++) {
                              if (secretMaps[i].continentName.toString() == value) {
                                setState(() {
                                  regions = secretMaps[i].areaNames!;
                                  selectedContinent = i;
                                });
                              }
                            }
                          },
                          positionCallback: (popupButtonObject, overlay) {
                            final decorationBox = _findBorderBox(popupButtonObject);

                            double translateOffset = 0;
                            if (decorationBox != null) {
                              translateOffset = decorationBox.size.height - popupButtonObject.size.height;
                            }

                            final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                            return RelativeRect.fromSize(
                              Rect.fromPoints(
                                popupButtonObject
                                    .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
                                    .translate(0, translateOffset),
                                popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero),
                                    ancestor: overlay),
                              ),
                              Size(overlay.size.width, overlay.size.height),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<String>(
                          validator: (v) => v == null ? "required field" : null,
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "지역 선택",
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: regions,
                          selectedItem: selectedItem,
                          onChanged: print,
                          positionCallback: (popupButtonObject, overlay) {
                            final decorationBox = _findBorderBox(popupButtonObject);

                            double translateOffset = 0;
                            if (decorationBox != null) {
                              translateOffset = decorationBox.size.height - popupButtonObject.size.height;
                            }

                            final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                            return RelativeRect.fromSize(
                              Rect.fromPoints(
                                popupButtonObject
                                    .localToGlobal(popupButtonObject.size.bottomLeft(Offset.zero), ancestor: overlay)
                                    .translate(0, translateOffset),
                                popupButtonObject.localToGlobal(popupButtonObject.size.bottomRight(Offset.zero),
                                    ancestor: overlay),
                              ),
                              Size(overlay.size.width, overlay.size.height),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0,
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRect(
                    child: PhotoView.customChild(
                      backgroundDecoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                      child: Image.asset(
                        "assets/map/test1.png",
                      ),
                      initialScale: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RenderBox? _findBorderBox(RenderBox box) {
    RenderBox? borderBox;

    box.visitChildren((child) {
      if (child is RenderCustomPaint) {
        borderBox = child;
      }

      final box = _findBorderBox(child as RenderBox);
      if (box != null) {
        borderBox = box;
      }
    });

    return borderBox;
  }
}

class StateService {
  static final List<String> states = [
    '흑장미 교회당',
    '황혼의 연무',
    '델파이 현',
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
    '1',
    '2',
    '3',
    'Bal1i',
    'Barcelo2na',
    'Pa3ris',
    'Buc4harest',
    'Ba5li',
    'Barc67elona',
    'Pari8s',
    'Bucha3rest',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(states);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
