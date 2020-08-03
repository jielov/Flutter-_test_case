import 'package:flutter/material.dart';
import 'package:videotest/modules/roll/roll_test_list_page.dart';

class RollTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'flutter列表滚动到指定位置',
      theme: new ThemeData(
          primaryColor: const Color(0xff43a047),
          accentColor: const Color(0xffffcc00),
          primaryColorBrightness: Brightness.dark),
      home: new ListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
