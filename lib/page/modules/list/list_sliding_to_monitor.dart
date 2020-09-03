
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:videotest/view/base_app_bar.dart';

class ListSlidingToMonitor extends StatefulWidget {
  @override
  _ListSlidingToMonitorState createState() => _ListSlidingToMonitorState();
}

class _ListSlidingToMonitorState extends State<ListSlidingToMonitor> {
  final ScrollController _scrollController = ScrollController();

  bool isEnd = false;
  double offset = 0;
  String notify = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
        isEnd = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleStr: '列表滑动监听', automaticallyImplyLeading: true)
          .commAppBar(context),
      body: Container(
        child: NotificationListener(
          onNotification: (notification) {
            String notify = "";
            if (notification is ScrollEndNotification) {
              notify = "顶部";
            } else if (notification is ScrollStartNotification) {
              notify = "滚动条";
            } else if (notification is UserScrollNotification) {
              notify = " 用户滚动";
            } else if (notification is ScrollUpdateNotification) {
              notify = "滚动更新";
            }
            setState(() {
              this.notify = notify;
            });
            return false;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  margin: EdgeInsets.only(left: ScreenAdapter.getWidth(20)),
                  height: ScreenAdapter.getHeight(60),
                  alignment: Alignment.centerLeft,
                  child: Text("第一 $index  个"),
                ),
              );
            },
            itemCount: 50,
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            _scrollController.animateTo(0,
                duration: Duration(seconds: 1), curve: Curves.bounceInOut);
          },
          child: Text("位置： ${offset.floor()}"),
        ),
        Container(
          width: ScreenAdapter.getWidth(0.4),
          height: ScreenAdapter.getHeight(30),
        ),
        FlatButton(
          onPressed: () {},
          child: Text(notify),
        ),
        Visibility(
          visible: isEnd,
          child: FlatButton(
            onPressed: () {},
            child: Text('到达底部'),
          ),
        )
      ],
    );
  }
}
