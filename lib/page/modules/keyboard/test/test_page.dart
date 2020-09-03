import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPageKeyboard extends StatefulWidget {

  @override
  _TestPageKeyboardState createState() => _TestPageKeyboardState();
}

class _TestPageKeyboardState extends State {
  String hint = '请输入…';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('弹出框键盘遮挡 获取键盘高度'),
      ),
      body: Container(
        color: Colors.green,
        child: InkWell(
          child: Center(
            child: Text(
            '点击弹出框',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Stack(
                      children: [
                        Positioned(
                          child: CupertinoAlertDialog(
                            title: const Text('输入框'),
                            content: Container(
                              color: Colors.white,
                              child: CupertinoTextField(
                                placeholder: hint,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(2)),
                                ),
                                maxLines: 5,
                                maxLength: 30,
                                maxLengthEnforced: true,
                              ),
                            ),
                          ),
                          bottom: MediaQuery
                              .of(context)
                              .viewInsets
                              .bottom > 0 ? 0 : 300, //300换成键盘高度值效果更好
                          left: 0,
                          right: 0,
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    ));
  }
}

/*
class _MyHomePageState extends State {

@override
void initState() {
super.initState();
}

String str = ‘’;

@override
Widget build(BuildContext context) {
MediaQuery.of(context);
print(‘build~~~~~’);
return Scaffold(
appBar: AppBar(
centerTitle: true,
title: Text(‘appA的flutter’),
),
body: Center(
child: TextField(),
)

);
1
}
}*/