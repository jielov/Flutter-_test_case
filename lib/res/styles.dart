
import 'dart:ui';

import 'package:flutter/material.dart';
import '../utils/adapter.dart';

class TextStyles {
  static TextStyle appBarCommStyle() => TextStyle(
      fontFamily: "pingfang",
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  static TextStyle commTextStyle() => TextStyle(
        fontFamily: "pingfang",
        decoration: TextDecoration.none,
      );

  static TextStyle commBoldTextStyle() => TextStyle(
        fontFamily: "pingfang",
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      );
}
