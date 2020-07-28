import 'package:flutter/material.dart';

// 一个颜色的三方插件
//import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:videotest/res/app_color.dart';

class HousePerson extends StatefulWidget {
  final int selectIndex; // 外部传入默认选择第几个
  final Function slideAction; // 滚动停止的回调方法，给外部传选中的索引值
  bool clearData; // 支持清楚数据功能，true代表恢复默认样式
  HousePerson({this.slideAction, this.selectIndex, this.clearData});

  @override
  _HousePersonState createState() => _HousePersonState();
}

class _HousePersonState extends State<HousePerson> {
  List<String> _list = [
    '9人',
    '10人',
    '10+',
    '不限',
    '1人',
    '2人',
    '3人',
    '4人',
    '5人',
    '6人',
    '7人',
    '8人',
  ];

  bool isScrollEndNotification = false;
  ScrollController _controller;
  double _startLocation = 0;
  double _endLocation = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double screenWidth = MediaQuery.of(context).size.width;
    int select = widget.selectIndex > 0 ? widget.selectIndex : 0;
    _controller = ScrollController(
      initialScrollOffset: (3000 + select) * (screenWidth - 40) / 7,
    );
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (widget.clearData) {
      _controller.jumpTo(3000 * (screenWidth - 40) / 7);
      widget.clearData = false;
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text(
                '最多宜居',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColor.color_888888,
                  fontFamily: 'PingFangSC-Semibold',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          _line(screenWidth - 40),
          Container(
            width: screenWidth - 40,
            color: Colors.white,
            height: 50,
            child: _listView(screenWidth - 40),
          ),
          _line(screenWidth - 40),
        ],
      ),
    );
  }

  Widget _line(double width) {
    return Container(
      width: width,
      height: 0.5,
      color: AppColor.color_EDEDED,
    );
  }

  Widget _listView(double width) {
    double singleItemWidth = width / 7;

    return Stack(
      children: <Widget>[
        NotificationListener<ScrollNotification>(
          child: ListView.builder(
            controller: _controller,
            itemCount: _list.length * 10000,
            itemExtent: width / 7,
            itemBuilder: (BuildContext context, int index) {
              return _listViewItem(
                  _list[index % _list.length], index, singleItemWidth);
            },
            scrollDirection: Axis.horizontal,
          ),
          onNotification: (ScrollNotification notification) {
            if (notification is ScrollStartNotification) {
              isScrollEndNotification = false;
              _startLocation = notification.metrics.pixels;
            }
            if (notification is ScrollEndNotification &&
                !isScrollEndNotification) {
              _endLocation = notification.metrics.pixels;
              isScrollEndNotification = true;
              double differ = _endLocation - _startLocation;
              double offset = 0;
              if (differ > 0) {
                offset = (differ.abs() ~/ singleItemWidth) * singleItemWidth;
                if (differ % singleItemWidth >= singleItemWidth / 2) {
                  offset += singleItemWidth;
                }
                _controller.jumpTo(_startLocation + offset);
              } else if (differ < 0) {
                differ = differ.abs();
                offset = ((differ ~/ singleItemWidth) * singleItemWidth);
                if ((differ % singleItemWidth) >= (singleItemWidth / 2)) {
                  offset += singleItemWidth;
                }
                _controller.jumpTo(_startLocation - offset);
              }
            }
            double result = notification.metrics.pixels / singleItemWidth;
            int round = result.round(); // 四舍五入
            widget.slideAction(round % 12); // 取余之后返回索引
            return true;
          },
        ),
        Positioned(
          left: width / 2 - 15,
          top: 0,
          child: Container(
            width: 30,
            height: 3,
            color: AppColor.color_f3f4ff,
          ),
        ),
        Positioned(
          left: width / 2 - 15,
          bottom: 0,
          child: Container(width: 30, height: 3, color: AppColor.color_EFF1F5),
        ),
      ],
    );
  }

  Widget _listViewItem(String title, int index, double singleItemWidth) {
    return GestureDetector(
      onTap: () {
        // 滚动到中间位置
        double offset = (index - 3) * singleItemWidth;
        _controller.jumpTo(offset);
        widget.slideAction((index - 3) % 12);
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: AppColor.color_999999,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
