
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:videotest/utils/adapter.dart';
import 'horizontal_scroll.dart';


class MarqueePage extends StatefulWidget {
  @override
  _MarqueePageState createState() => _MarqueePageState();
}

class _MarqueePageState extends State<MarqueePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:  Text('跑马灯效果'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _marqueeview(),
          _marqueeView(),
        ],
      ),
    );
  }
  ///横向滚动
  Widget _marqueeview() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 31,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 10),
            child: Center(
              child: Image.asset(
                'assets/gsy_cat.png',
                width: 15,
                height: 15,
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
                child: YYMarquee(
                  stepOffset: 200.0,
                  duration: Duration(seconds: 5),
                  paddingLeft: 50.0,
                  children: [
                    Text(
                      '手机用户155****0523借款成功',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFEE8E2B),
                      ),
                    ),
                    Text(
                      '手机用户1345****0531借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                    Text(
                      '手机用户145****0555借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                    Text(
                      '手机用户175****0594借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                    Text(
                      '手机用户185****0521借款成功',
                      style: TextStyle(fontSize: 13, color: Color(0xFFEE8E2B)),
                    ),
                  ],
                ),
              )),
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xFFFFF2E6),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
  //纵向滚动
  final list = [
    '3月1日王女士（卡号5346）成功借款10000',
    '4月3日李女士（卡号3232）成功借款30000',
    '2月6日王先生（卡号4432）成功借款10000',
    '4月2日刘女士（卡号8908）成功借款50000',
    '1月1日张女士（卡号0894）成功借款100000',
    '10月1日陈先生（卡号7233）成功借款80000',
    '9月1日吴女士（卡号7298）成功借款10000',
  ];
  // 轮播
  Widget _marqueeView() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Container(
        alignment: Alignment.center,
        color: Colors.red,
        height: ScreenAdapter.getHeight(34),
        child: _marqueeSwiper(),
      ),
    );
  }

  Widget _marqueeSwiper() {
    return Container(
      height: ScreenAdapter.getHeight(34),
//      width: ScreenAdapter.getHeight(34),
      alignment: Alignment.center,
      child: Swiper(
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        loop: true,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          // return Text('3月1日李女士（卡号5666）成功借款10000');
          return Container(
            height: ScreenAdapter.getHeight(34),
            alignment: Alignment.center,
            child: Text(
              list[index],
              style: TextStyle(
                fontSize: ScreenAdapter.getHeight(13),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

}
