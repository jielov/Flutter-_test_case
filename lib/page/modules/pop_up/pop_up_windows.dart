import 'dart:html';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/utils/toast_util.dart';
import 'package:videotest/view/base_app_bar.dart';

class PopUpWindows extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: 'flutter之Hero动画',
        automaticallyImplyLeading: true,
      ).commAppBar(context),
      body: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showPhoto(BuildContext context, Widget image) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return GestureDetector(
        child: SizedBox.expand(
          child: Hero(
            tag: image,
            child: image,
          ),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      );
    }));
  }

  List<Widget> _list = <Widget>[
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/start_01.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('flutter展示底部弹窗'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: const Text('展示底部弹窗'),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (BuildContext context) {
                  return Container(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      padding: const EdgeInsets.all(4.0),
                      children: _list.map(
                        (Widget img) {
                          return GestureDetector(
                            onTap: () {
                              showPhoto(context, img);
                            },
                            child: Hero(
                              tag: img,
                              child: img,
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              _handleTap();
            },
            child: Text("底部选择"),
          )
        ],
      ),
    );
  }

  //底部弹窗
  _handleTap() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                "从相册选择",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                ToastUtil.showToastForShort("打开相册");
                Navigator.of(context).pop();
              },
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                ToastUtil.showToastForShort("打开相册");
                Navigator.of(context).pop();
              },
              child: Text(
                "拍照",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: TextStyle(
                fontSize: 14,
                color: AppColor.color_888888,
              ),
            ),
          ),
        );
      },
    );
  }
}
