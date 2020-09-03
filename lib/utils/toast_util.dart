import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'adapter.dart';

class ToastUtil {
  static void showToastForShort(String msg, {ToastGravity gravity}) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      gravity: gravity ?? ToastGravity.CENTER,
      fontSize: ScreenAdapter.getFontSize(14),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static void showToastForLong(String msg, {ToastGravity gravity}) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.white,
      gravity: gravity ?? ToastGravity.CENTER,
      fontSize: ScreenAdapter.getFontSize(14),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
