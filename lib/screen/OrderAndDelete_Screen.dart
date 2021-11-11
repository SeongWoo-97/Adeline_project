import 'package:adeline_app/model/user/characterModel/characterModel.dart';
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constant.dart';

class OrderAndDeleteScreen extends StatefulWidget {
  final characterList;

  OrderAndDeleteScreen(this.characterList);

  @override
  _OrderAndDeleteScreenState createState() => _OrderAndDeleteScreenState();
}

class _OrderAndDeleteScreenState extends State<OrderAndDeleteScreen> {
  late List<CharacterModel> list;
  late DragAndDropList charactersOrder = DragAndDropList(children: []);

  @override
  void initState() {
    super.initState();
    list = widget.characterList;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캐릭터 순서 및 삭제'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, list);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: DragAndDropLists(
        children: [characterOrder()],
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        listPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        itemDecorationWhileDragging: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        listInnerDecoration: BoxDecoration(
          color: Colors.white, // background 색
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        lastItemTargetHeight: 8,
        addLastItemTargetHeightToTop: true,
        lastListTargetSize: 40,
        listDragHandle: DragHandle(
          verticalAlignment: DragHandleVerticalAlignment.top,
          child: Container(),
        ),
        itemDragHandle: DragHandle(
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.menu,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  DragAndDropList characterOrder() {
    charactersOrder = DragAndDropList(
      children: List.generate(list.length, (index) {
        return DragAndDropItem(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(color: Colors.grey, width: 0.8),
            ),
            child: ListTile(
              title: Row(
                children: [
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Image.asset(
                        'assets/etc/Minus.png',
                        width: 25,
                        height: 25,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      showPlatformDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PlatformAlertDialog(
                            content: Text(
                              '${list[index].nickName} 캐릭터를 \n삭제하시겠습니까?',
                              style: contentStyle.copyWith(fontSize: 15),
                            ),
                            actions: [
                              PlatformDialogAction(
                                child: PlatformText('삭제'),
                                // 캐릭터 순서 페이지로 이동
                                onPressed: () {
                                  list.removeAt(index);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                              ),
                              PlatformDialogAction(
                                child: PlatformText('취소'),
                                // 캐릭터 순서 페이지로 이동
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list[index].nickName.toString(), style: contentStyle.copyWith(fontSize: 16)),
                      Text(
                        'Lv.${list[index].level} ${list[index].job}',
                        style: contentStyle.copyWith(fontSize: 14, color: Colors.black54),
                      )
                    ],
                  ),
                ],
              ),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              onTap: () async {
                // list[index] = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContentSettingsScreen(characterModelList[index])));
                setState(() {});
              },
            ),
          ),
        );
      }),
    );
    return charactersOrder;
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = charactersOrder.children.removeAt(oldItemIndex);

      charactersOrder.children.insert(newItemIndex, movedItem);

      var movedItem2 = list.removeAt(oldItemIndex);
      list.insert(newItemIndex, movedItem2);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // var movedList = charactersOrder.removeAt(oldListIndex);
      // _contents.insert(newListIndex, movedList);
    });
  }
}
