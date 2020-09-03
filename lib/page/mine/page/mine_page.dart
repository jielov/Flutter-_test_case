import 'package:flutter/material.dart';
import 'package:videotest/view/base_app_bar.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: "我的",
      ).commAppBar(context),
      body: Container(
        child: Text("我的"),
      ),
    );
  }
}
