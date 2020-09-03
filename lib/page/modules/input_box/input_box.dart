
import 'package:flutter/material.dart';
import 'package:videotest/view/base_app_bar.dart';
/// 在 Flutter 中有很多内置的 Controller
/// 大部分内置控件都可以通过 Controller 设置和获取控件参数
/// 比如 TextField 的 TextEditingController
/// 比如 ListView  的 ScrollController
/// 一般想对控件做 OOXX 的事情，先找个 Controller 就对了。
class InputBox extends StatefulWidget {
  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController controller = new TextEditingController(text: "init 文本");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: '输入框',
        automaticallyImplyLeading: true
      ).commAppBar(context),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: TextField(
            controller: controller,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            print('当前文字 ${controller.text}');
            controller.text = "改变了FloatingActionButton";
          },
        child: Text('改变'),
      ),
    );
  }
}
