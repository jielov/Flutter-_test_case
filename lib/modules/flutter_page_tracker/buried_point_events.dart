import 'package:flutter/material.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';

class BuriedPointEvents extends StatefulWidget {
  @override
  _BuriedPointEventsState createState() => _BuriedPointEventsState();
}

class _BuriedPointEventsState extends State<BuriedPointEvents> with  PageTrackerAware,TrackerPageMixin{
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void didPageView() {
    // TODO: implement didPageView
    super.didPageView();
    // 发送页面露出事件
  }
  @override
  void didPageExit() {
    // TODO: implement didPageExit
    super.didPageExit();
    // 发送页面离开事件
  }

}

