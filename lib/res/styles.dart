import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:videotest/utils/adapter.dart';

import 'app_color.dart';

class TextStyles {
  static TextStyle appBarCommStyle() => TextStyle(
    fontFamily: "pingfang",
        color: AppColor.color_333333,
        fontSize: ScreenAdapter.getFontSize(16),
        fontWeight: FontWeight.normal,
      );
}
