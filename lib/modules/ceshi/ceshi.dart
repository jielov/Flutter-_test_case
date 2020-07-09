

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {
  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {

  final _bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();
  // 底部滑动窗口
  _openBottomSheet() {
    _bottomSheetScaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return BottomAppBar(
        child: Container(
          height: 90.0,
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Icon(Icons.pause_circle_outline),
              SizedBox(width: 16.0,),
              Text('01:30 / 03:30'),
              Expanded(child: Text('Fix you - Coldplay', textAlign: TextAlign.right,)),
            ],
          ),
        ),
      );
    });
  }
  // 对话框式底部滑动窗口
  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Container(
        height: 200,
        child: Column(
          children: <Widget>[
            ListTile(title: Text('选项一'), onTap: () { Navigator.pop(context, '选项一');},),
            ListTile(title: Text('选项二'), onTap: () { Navigator.pop(context, '选项二');},),
            ListTile(title: Text('选项三'), onTap: () { Navigator.pop(context, '选项三');},),
          ],
        ),
      );
    });

    print('点击了$option');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _bottomSheetScaffoldKey,
      appBar: AppBar(title: Text('BottomSheet'), elevation: 0.0,),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(child: Text('Open BottomSheet'), onPressed: _openBottomSheet),
                FlatButton(child: Text('Modal BottomSheet'), onPressed: _openModalBottomSheet),
              ],
            ),
          ],
        ),
      ),
    );
  }
}