import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:videotest/view/base_app_bar.dart';

import 'arc_painter.dart';

class SetsTabPage extends StatefulWidget {
  @override
  _SetsTabPageState createState() => _SetsTabPageState();
}

class _SetsTabPageState extends State<SetsTabPage>
    with SingleTickerProviderStateMixin {
  int _activeIndex = 0; //激活项
  double _height = 48; //导航栏高度
  double _floatRadius; //悬浮图标半径
  double _moveTween = 0; //移动补间
  double _padding = 10; //浮动图标与圆弧之间的间隙
  AnimationController _animationController; //动画控制器
  Animation<double> _moveAnimation; //移动动画
  //导航项
  List _naVs = [
    Icons.search,
    Icons.ondemand_video,
    Icons.music_video,
    Icons.insert_comment,
    Icons.person
  ];

  @override
  void initState() {
    // TODO: implement initState
    _floatRadius = _height * 2 / 3;
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 400)); // 动画时长
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double singleWidth = width / _naVs.length;
    return Container(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: BaseAppBar(
              titleStr: "底部浮动导航栏",
              elevation: 0,
              automaticallyImplyLeading: true,
            ).commAppBar(context),
            backgroundColor: Colors.white70,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  //悬浮图标
                  Positioned(
                    top: _animationController.value <= 0.5
                        ? (_animationController.value *
                                _height *
                                _padding /
                                2) -
                            _floatRadius / 3 * 2
                        : (1 - _animationController.value) *
                                _height *
                                _padding /
                                2 -
                            _floatRadius / 3 * 2,
                    left: _moveTween * singleWidth +
                        (singleWidth - _floatRadius) / 2 -
                        _padding / 2,
                    child: DecoratedBox(
                      decoration:
                          ShapeDecoration(shape: CircleBorder(), shadows: [
                        BoxShadow(
                          //阴影效果
                          blurRadius: _padding / 2,
                          offset: Offset(0, _padding / 2),
                          spreadRadius: 0,
                          color: Colors.black26,
                        )
                      ]),
                      child: CircleAvatar(
                        radius: _floatRadius - _padding, //浮动图标和圆弧之间设置10pixel间隙
                        backgroundColor: Colors.white,
                        child: Icon(
                          _naVs[_activeIndex],
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  //所有图标
                  CustomPaint(
                    child: SizedBox(
                      height: _height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: _naVs
                            .asMap()
                            .map(
                              (i, v) => MapEntry(
                                i,
                                GestureDetector(
                                  child: Icon(
                                    v,
                                    color: _activeIndex == i
                                        ? Colors.transparent
                                        : Colors.grey,
                                  ),
                                  onTap: () {
                                    _switchNav(i);
                                  },
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      ),
                    ),
                    painter: ArcPainter(
                      _naVs.length,
                      _moveTween,
                      _padding,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//切换导航
  _switchNav(int newIndex) {
    double oldPosition = _activeIndex.toDouble();

    double newPosition = newIndex.toDouble();

    if (oldPosition != newPosition &&
        _animationController.status != AnimationStatus.forward) {
      _animationController.reset();

      _moveAnimation = Tween(begin: oldPosition, end: newPosition).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCubic))
        ..addListener(() {
          setState(() {
            _moveTween = _moveAnimation.value;
          });
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _activeIndex = newIndex;
            });
          }
        });

      _animationController.forward();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
}
