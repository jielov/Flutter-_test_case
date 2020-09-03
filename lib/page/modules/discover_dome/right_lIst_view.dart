
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:videotest/utils/adapter.dart';

class RightLIstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List rightTitles = [
      '测试数据就是这样怎么了',
      '这个短',
      '这个长是不是是',
      '我就是随便写写',
      '是短',
      '这个长不长也',
      '就那样也不长',
      '谁说的这个是最后的我就写长点儿你能拿我怎么办打不到我吧我就是这么强大'
    ];
    return Container(
      margin: EdgeInsets.only(
        left: ScreenAdapter.getWidth(10),
        top: ScreenAdapter.getHeight(10),
      ),
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: rightTitles.map((childNode) {
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                padding: EdgeInsets.all(3),
                color: getRandpmColor(),
                child: Text(
                  childNode,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenAdapter.getFontSize(14),
                      shadows: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.2, 0.2),
                        )
                      ]),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

getRandpmColor() {
  return Color.fromARGB(255, Random.secure().nextInt(255),
      Random.secure().nextInt(255), Random.secure().nextInt(255));
}
