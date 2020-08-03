import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videotest/modules/roll/filtrate_condition_view.dart';
import 'package:videotest/utils/adapter.dart';

class RollPage extends StatefulWidget {
  @override
  _RollPageState createState() => _RollPageState();
}

class _RollPageState extends State<RollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多项选择'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: ScreenAdapter.getWidth(30)),
        child: Column(
          children: <Widget>[
            FiltrateConditionView(
              type: FiltrateConditionType.year,
            ),
            FiltrateConditionView(
              type: FiltrateConditionType.region,
            ),
            FiltrateConditionView(
              type: FiltrateConditionType.classify,
            ),
          ],
        ),
      ),
    );
  }
}
