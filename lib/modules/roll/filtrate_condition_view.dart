import 'package:flutter/material.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/res/dimens.dart';
import 'package:videotest/utils/adapter.dart';

enum FiltrateConditionType {
  year,
  region,
  classify,
}

class FiltrateConditionView extends StatefulWidget {
  final FiltrateConditionType type;

  const FiltrateConditionView({
    Key key,
    @required this.type,
  }) : super(key: key);

  @override
  FiltrateConditionViewState createState() => new FiltrateConditionViewState();
}

class FiltrateConditionViewState extends State<FiltrateConditionView> {
  List<String> filtrateStrList;
  int selectIndex = 0; //默认选中第一个

  ScrollController _controller;
  bool isScrollEndNotification = false;
  double _startLocation = 0;
  double _endLocation = 0;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case FiltrateConditionType.year:
        filtrateStrList = [
          "全部",
          "2020",
          "2019",
          "2018",
          "2017",
          "2016",
          "2015",
          "2014",
        ];
        break;
      case FiltrateConditionType.region:
        filtrateStrList = [
          "全部",
          "内地",
          "美国",
          "泰国",
          "英国",
          "香港",
          "俄罗斯",
          "日本",
        ];
        break;
      case FiltrateConditionType.classify:
        filtrateStrList = [
          "全部",
          "剧情",
          "动作",
          "科幻",
          "喜剧",
          "爱情",
          "恐怖",
          "惊悚",
        ];
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double screenWidth = MediaQuery.of(context).size.width;
    _controller = ScrollController(
      initialScrollOffset: filtrateStrList.length / (screenWidth) / 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double singleItemWidth = screenWidth / 5;

    return Container(
      height: ScreenAdapter.getHeight(40),
      child: NotificationListener<ScrollNotification>(
        child: ListView.builder(
          padding: EdgeInsets.only(
            left: Dimens.marginLeft,
            top: ScreenAdapter.getHeight(15),
            right: Dimens.marginRight,
          ),
          controller: _controller,
          itemExtent: screenWidth / 5,
          scrollDirection: Axis.horizontal,
          itemCount: filtrateStrList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectIndex = index;
                  double offset = (index - 2) * singleItemWidth;
                  _controller.jumpTo(offset);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenAdapter.getWidth(10),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenAdapter.getWidth(2.5))),
                    color: selectIndex == index
                        ? AppColor.color_F6F7F9
                        : Colors.transparent),
                child: Text(
                  filtrateStrList[index],
                  style: selectIndex == index
                      ? TextStyle(
                          fontSize: 12,
                          color: AppColor.color_0BB4E4,
                        )
                      : TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                ),
              ),
            );
          },
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
            double offset = 1;
            if (differ > 1) {
              offset = (differ.abs() ~/ singleItemWidth) * singleItemWidth;
              if (differ % singleItemWidth >= singleItemWidth / 2) {
                offset += singleItemWidth;
              }
              _controller.jumpTo(_startLocation + offset);
            } else if (differ < 1) {
              differ = differ.abs();
              offset = ((differ ~/ singleItemWidth) * singleItemWidth);
              if ((differ % singleItemWidth) >= (singleItemWidth / 2)) {
                offset += singleItemWidth;
              }
              _controller.jumpTo(_startLocation - offset);
            }
          }
          return true;
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
