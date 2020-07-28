import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:videotest/res/dimens.dart';
import 'package:videotest/res/styles.dart';
import 'package:videotest/utils/adapter.dart';

import 'bar_back_view.dart';

class BaseAppBar {
  final String titleStr;
  final Widget leading;
  final bool showDismiss;
  final double elevation;
  final bool automaticallyImplyLeading;
  final List<Widget> actions;

  BaseAppBar({
    this.titleStr,
    this.leading,
    this.showDismiss,
    this.elevation = 0.5,
    this.automaticallyImplyLeading,
    this.actions,
  });

  // 标题通用样式
  TextStyle _appBarCommStyle() {
    return TextStyles.appBarCommStyle();
  }

  // 简单样式AppBar
  Widget commAppBar(BuildContext context) {
    _buildLeading() {
      return BarBackView(
        paddingLeft: 0,
      );
    }

    if (automaticallyImplyLeading != null) {
      return PreferredSize(
        child: AppBar(
          leading: this.leading ?? _buildLeading(),
          automaticallyImplyLeading: this.automaticallyImplyLeading,
          title: Text(
            TextUtil.isEmpty(titleStr) ? "" : titleStr,
            style: _appBarCommStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          elevation: this.elevation,
          actions: this.actions,
        ),
        preferredSize: Size.fromHeight(
          ScreenAdapter.getHeight(Dimens.appBarHeight),
        ),
      );
    } else {
      return PreferredSize(
        child: AppBar(
          title: Text(
            TextUtil.isEmpty(titleStr) ? "" : titleStr,
            style: _appBarCommStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: this.elevation,
          actions: this.actions,
        ),
        preferredSize: Size.fromHeight(
          ScreenAdapter.getHeight(Dimens.appBarHeight),
        ),
      );
    }
  }

  //网页AppBar
  Widget webAppBar(BuildContext context, PreferredSizeWidget bottom) {
    _buildLeading() {
      return BarBackView(
        paddingLeft: 0,
      );
    }

    if (automaticallyImplyLeading != null) {
      return PreferredSize(
        child: AppBar(
          leading: this.leading ?? _buildLeading(),
          automaticallyImplyLeading: this.automaticallyImplyLeading,
          title: Text(
            TextUtil.isEmpty(titleStr) ? "" : titleStr,
            style: _appBarCommStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: this.elevation,
          actions: this.actions,
          bottom: bottom,
        ),
        preferredSize: Size.fromHeight(
          ScreenAdapter.getHeight(Dimens.appBarHeight),
        ),
      );
    } else {
      return PreferredSize(
        child: AppBar(
          title: Text(
            TextUtil.isEmpty(titleStr) ? "" : titleStr,
            style: _appBarCommStyle(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: this.elevation,
          actions: this.actions,
          bottom: bottom,
        ),
        preferredSize: Size.fromHeight(
          ScreenAdapter.getHeight(Dimens.appBarHeight),
        ),
      );
    }
  }
}
