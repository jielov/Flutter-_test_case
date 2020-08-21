import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:videotest/view/base_app_bar.dart';

class SeekSliderPage extends StatefulWidget {
  @override
  _SeekSliderPageState createState() => _SeekSliderPageState();
}

class _SeekSliderPageState extends State<SeekSliderPage> {
  String _leftPrice = '0';
  String _rightPrice = '不限';

  double _leftImageMargin = 20;
  double _rightImageMargin = 20;
  double _leftBlackLineW = 0; // 左边黑线的宽度
  double _rightBlackLineW = 0; // 右边黑线的宽度

  int _leftImageCurrentIndex = 0; // 左边选中的价格索引
  int _rightImageCurrentIndex = 0; // 右边选中的价格索引

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: "拖拽进度条",
        automaticallyImplyLeading: true,
      ).commAppBar(context),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _priceRangeBlock(),
          SizedBox(
            height: 10,
          ),
          _priceBlock(_leftPrice, _rightPrice),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: <Widget>[
              _lineBlock(context, screenWidth),
              _leftImageBlock(context, screenWidth),
              _rightImageBlock(context, screenWidth),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _priceBottomBlock(context)
        ],
      ),
    );
  }

  /*
      * title模块
      * */
  _priceRangeBlock() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Text(
          '价格范围',
          style: TextStyle(
            fontSize: 15,
            color: ColorUtil.color('#212121'),
            fontFamily: 'PingFangSC-Semibold',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /*
      * 价格区间
      * leftPrice：选中的起始价格
      * rightPrice： 选中的最大价格
      * */
  _priceBlock(String leftPrice, String rightPrice) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Text(
          '$leftPrice-$rightPrice',
          style: TextStyle(
            fontSize: 12,
            color: ColorUtil.color('#757575'),
            fontFamily: 'PingFangSC-Regular',
          ),
        ),
      ],
    );
  }

  /*
      * 横线视图模块,包括黄色横线和黑色横线
      * */
  _lineBlock(BuildContext context, double screenWidth) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Stack(
          children: <Widget>[
            Container(
              // 黄色横线
              color: Colors.white,
              height: 30,
              width: screenWidth - 40,
              alignment: Alignment.center,
              child: Container(
                color: ColorUtil.color('#FED836'),
                height: 4,
                width: screenWidth - 40,
              ),
            ),
            Positioned(
                // 左边黑色横线
                left: 0,
                top: 13,
                child: Container(
                  height: 4,
                  width: _leftBlackLineW,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left: BorderSide(color: Colors.black, width: 1),
                          top: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1))),
                )),
            Positioned(
                // 右边黑色横线
                right: 0,
                top: 13,
                child: Container(
                  height: 4,
                  width: _rightBlackLineW,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          right: BorderSide(color: Colors.black, width: 1),
                          top: BorderSide(color: Colors.black, width: 1),
                          bottom: BorderSide(color: Colors.black, width: 1))),
                )),
          ],
        ),
      ],
    );
  }

  /*
      * 左边image滑块，使用到：_imageItem
      * */
  _leftImageBlock(BuildContext context, double screenWidth) {
    double singleW = (screenWidth - 40) / 6;
    return Positioned(
        left: _leftImageMargin,
        top: 0,
        child: GestureDetector(
          child: _imageItem(),
          //水平方向移动
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            print('拖拽中');
            if (_leftImageMargin < 20) {
              //处理左边边界
              _leftImageMargin = 20;
              _leftBlackLineW = 2;
            } else if (((screenWidth - (_rightImageMargin + 30)) -
                    (_leftImageMargin + 30)) <
                (singleW - 45)) {
              // 处理两球相遇情况
              _leftImageMargin =
                  screenWidth - (_rightImageMargin + singleW + 15);
              _leftBlackLineW = _leftImageMargin - 20;
            } else {
              _leftImageMargin += details.delta.dx;
              _leftBlackLineW =
                  _leftImageMargin - 20 >= 0 ? _leftImageMargin - 20 : 2;
            }
            setState(() {}); // 刷新UI
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            double singleW = (screenWidth - 40) / 6;
            double _leftImageMarginFlag = _leftImageMargin;
            print('拖拽结束');
            if (_leftImageMarginFlag < singleW / 2) {
              _leftImageMargin = 20;
              _leftBlackLineW = 2;
              _leftImageCurrentIndex = 0;
              _leftPrice = '¥0';
            } else if (_leftImageMarginFlag < singleW * 1.5) {
              _leftImageMargin = singleW + 5;
              _leftBlackLineW = _leftImageMargin;
              _leftImageCurrentIndex = 1;
              _leftPrice = '¥200';
            } else if (_leftImageMarginFlag < singleW * 2.5) {
              _leftImageMargin = singleW * 2 + 5;
              _leftBlackLineW = _leftImageMargin;
              _leftImageCurrentIndex = 2;
              _leftPrice = '¥300';
            } else if (_leftImageMarginFlag < singleW * 3.5) {
              _leftImageMargin = singleW * 3 + 5;
              _leftBlackLineW = _leftImageMargin;
              _leftImageCurrentIndex = 3;
              _leftPrice = '¥400';
            } else if (_leftImageMarginFlag < singleW * 4.5) {
              _leftImageMargin = singleW * 4 + 5;
              _leftBlackLineW = _leftImageMargin;
              _leftImageCurrentIndex = 4;
              _leftPrice = '¥500';
            } else if (_leftImageMarginFlag < singleW * 5.5) {
              _leftImageMargin = singleW * 5 + 5;
              _leftBlackLineW = _leftImageMargin;
              _leftImageCurrentIndex = 5;
              _leftPrice = '¥600';
            } else {}
            print('选中第$_leftImageCurrentIndex个');
            setState(() {}); // 刷新UI
          },
        ));
  }

  /*
      * 右边image滑块，使用到：_imageItem
      * */
  _rightImageBlock(BuildContext context, double screenWidth) {
    double singleW = (screenWidth - 40) / 6;
    return Positioned(
      right: _rightImageMargin,
      top: 0,
      child: GestureDetector(
        child: _imageItem(),
        //水平方向移动
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          print(_rightImageMargin);
          if (_rightImageMargin < 20) {
            //处理右边边界
            _rightImageMargin = 20;
            _rightBlackLineW = 2;
          } else if (((screenWidth - (_rightImageMargin + 30)) -
                  (_leftImageMargin + 30)) <
              (singleW - 45)) {
            // 处理两球相遇情况
            _rightImageMargin = screenWidth - (_leftImageMargin + 15 + singleW);
            _rightBlackLineW = _rightImageMargin - 20;
          } else {
            _rightImageMargin -= details.delta.dx;
            _rightBlackLineW =
                _rightImageMargin - 20 >= 0 ? _rightImageMargin - 20 : 2;
          }
          setState(() {}); // 刷新UI
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          double singleW = (screenWidth - 40) / 6;
          double _rightImageMarginFlag = _rightImageMargin;
          print('拖拽结束');
          if (_rightImageMarginFlag < singleW / 2) {
            _rightImageMargin = 20;
            _rightBlackLineW = 2;
            _rightImageCurrentIndex = 0;
            _rightPrice = '不限';
          } else if (_rightImageMarginFlag < singleW * 1.5) {
            _rightImageMargin = singleW + 5;
            _rightBlackLineW = _rightImageMargin;
            _rightImageCurrentIndex = 1;
            _rightPrice = '¥600';
          } else if (_rightImageMarginFlag < singleW * 2.5) {
            _rightImageMargin = singleW * 2 + 5;
            _rightBlackLineW = _rightImageMargin;
            _rightImageCurrentIndex = 2;
            _rightPrice = '¥500';
          } else if (_rightImageMarginFlag < singleW * 3.5) {
            _rightImageMargin = singleW * 3 + 5;
            _rightBlackLineW = _rightImageMargin;
            _rightImageCurrentIndex = 3;
            _rightPrice = '¥400';
          } else if (_rightImageMarginFlag < singleW * 4.5) {
            _rightImageMargin = singleW * 4 + 5;
            _rightBlackLineW = _rightImageMargin;
            _rightImageCurrentIndex = 4;
            _rightPrice = '¥300';
          } else if (_rightImageMarginFlag < singleW * 5.5) {
            _rightImageMargin = singleW * 5 + 5;
            _rightBlackLineW = _rightImageMargin;
            _rightImageCurrentIndex = 5;
            _rightPrice = '¥200';
          }
          print('选中第$_rightImageCurrentIndex个');
          setState(() {}); // 刷新UI
        },
      ),
    );
  }

  // 滑块的image
  _imageItem() {
//    return Image.asset(
//      'assets/images/house_price_sliding.png',
//      width: 30,
//      height: 30,
//    );
    return Icon(Icons.flight_takeoff);
  }

  /*
      * 底部价格大模块，使用到：_priceItem，_priceTitleList
      * */
  _priceBottomBlock(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final singleW = (screenWidth - 40) / 6;
    double margin = 14.5;
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 17,
          width: screenWidth - 40,
        ),
        Positioned(
          left: 7.5,
          top: 0,
          child: _priceItem(_priceTitleList[0]),
        ),
        Positioned(
          left: singleW - margin,
          top: 0,
          child: _priceItem(_priceTitleList[1]),
        ),
        Positioned(
          left: singleW * 2 - margin,
          top: 0,
          child: _priceItem(_priceTitleList[2]),
        ),
        Positioned(
          left: singleW * 3 - margin,
          top: 0,
          child: _priceItem(_priceTitleList[3]),
        ),
        Positioned(
          left: singleW * 4 - margin,
          top: 0,
          child: _priceItem(_priceTitleList[4]),
        ),
        Positioned(
          left: singleW * 5 - margin,
          top: 0,
          child: _priceItem(_priceTitleList[5]),
        ),
        Positioned(
          right: 3,
          bottom: 1,
          child: _priceItem(_priceTitleList[6]),
        ),
      ],
    );
  }

  /*
      * 底部价格每个item
      * */
  _priceItem(String title) {
    return Text(
      title,
      style: TextStyle(
        color: ColorUtil.color('#212121'),
        fontFamily: 'PingFangSC-Regular',
        fontSize: 12,
      ),
    );
  }

  /*
      * 价格选择的数组
      * */
  List<String> _priceTitleList = <String>[
    '¥0',
    '¥200',
    '¥300',
    '¥400',
    '¥500',
    '¥600',
    '不限'
  ];
}
