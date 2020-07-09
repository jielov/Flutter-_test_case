import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static void setDesignWHs(BuildContext context, double width, double height,
      {bool allowFontScaling = false}) {
    ScreenUtil.init(
        context,
        width: width, height: height, allowFontScaling: allowFontScaling);
  }

  static num getWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static num getHeight(double height) {
    return ScreenUtil().setWidth(height);
  }

  static num getFontSize(double fontSize) {
    return ScreenUtil().setSp(fontSize);
  }
}


