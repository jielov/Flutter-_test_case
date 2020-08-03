import 'package:flutter/material.dart';
import 'package:videotest/utils/adapter.dart';

import 'home/page/home_page.dart';

void main()async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter 案例演示',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomePage(title: 'flutter 案例演示'),
      routes: routers,
    );
  }
}
