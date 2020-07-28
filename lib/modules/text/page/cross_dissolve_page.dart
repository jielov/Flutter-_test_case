
import 'package:flutter/material.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:videotest/view/base_app_bar.dart';

class CrossDissolvePage extends StatefulWidget {
  @override
  _CrossDissolvePageState createState() => _CrossDissolvePageState();
}

class _CrossDissolvePageState extends State<CrossDissolvePage> {
  // 初始opacityLevel为1.0为可见状态，为0.0时不可见
  double opacityLevel = 1.0;
  _changeOpacity(){
    //调用setState（）  根据opacityLevel当前的值重绘ui
    // 当用户点击按钮时opacityLevel的值会（1.0=>0.0=>1.0=>0.0 ...）切换
    // 所以AnimatedOpacity 会根据opacity传入的值(opacityLevel)进行重绘 Widget
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0 );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleStr: "文字动画 淡入淡出").commAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          AnimatedOpacity(
            opacity: opacityLevel,
            duration: Duration(
                //过渡时间：1
                seconds: 1),
            child: Container(
              padding: EdgeInsets.only(
                  right: ScreenAdapter.getWidth(20),
                  bottom: ScreenAdapter.getWidth(15),
                  left: ScreenAdapter.getWidth(20)),
              child: Text(
                  '和React Native一样，Flutter也提供响应式的视图，Flutter采用不同的方法避免由JavaScript桥接器引起的性能问题，即用名为Dart的程序语言来编译。Dart是用预编译的方式编译多个平台的原生代码，这允许Flutter直接与平台通信，而不需要通过执行上下文切换的JavaScript桥接器。编译为原生代码也可以加快应用程序的启动时间。实际上，Flutter是唯一提供响应式视图而不需要JavaScript桥接器的移动SDK，这就足以让Fluttter变得有趣而值得一试，但Flutter还有一些革命性的东西，即它是如何实现UI组件的？'),
            ),
          ),
          RaisedButton(
            child: Container(
              child: Text('点击事件'),
            ),
            onPressed: _changeOpacity,
          )
        ],
      ),
    );
  }
}
