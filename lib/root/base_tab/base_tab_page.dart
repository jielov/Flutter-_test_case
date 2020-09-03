import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videotest/page/home/page/home_page.dart';
import 'package:videotest/page/mine/page/mine_page.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/res/styles.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:videotest/utils/toast_util.dart';

class BaseTabPage extends StatefulWidget {
  @override
  _BaseTabPageState createState() => _BaseTabPageState();
}

class _BaseTabPageState extends State<BaseTabPage> {
  int _tabIndex = 0;
  int _lastClickTime = 0;
  List<Widget> tabPages;
  List<BottomNavigationBarItem> bottomBarItems;
  PageController _pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabPages = [
      HomePage(title: 'flutter 案例演示'),
      MinePage(),
    ];
  }

  getBottomBarIcon(int index) {
    if (index == 0) {
      return (index == _tabIndex
          ? Icon(Icons.home, color: AppColor.color_4C64FC)
          : Icon(Icons.home, color: Colors.black12));
    } else if (index == 1) {
      return (index == _tabIndex
          ? Icon(Icons.assignment_ind, color: AppColor.color_4C64FC)
          : Icon(Icons.assignment_ind, color: Colors.black12));
    }
    return null;
  }

//图片大小
  _getAssetIcon(String path) {
    return Container(
        padding: EdgeInsets.only(bottom: ScreenAdapter.getHeight(3)),
        child: Image.asset(path,
            width: ScreenAdapter.getWidth(18),
            height: ScreenAdapter.getHeight(18)));
  }

  Text _getBottomBarTitle(int index) {
    if (index == 0) {
      return Text("首页");
    } else if (index == 1) {
      return Text("我的");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //    ///初始化ScreenUtil
    ScreenAdapter.setDesignWHs(context, 375, 667, allowFontScaling: true);

    bottomBarItems = [
      BottomNavigationBarItem(
          icon: getBottomBarIcon(0), title: _getBottomBarTitle(0)),
      BottomNavigationBarItem(
          icon: getBottomBarIcon(1), title: _getBottomBarTitle(1)),
    ];

    return WillPopScope(
      onWillPop: _doubleExit,
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, index) => tabPages[index],
          itemCount: tabPages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppColor.color_4C64FC,
          unselectedItemColor: AppColor.color_999999,
          unselectedLabelStyle: TextStyles.commTextStyle().copyWith(
            color: AppColor.color_999999,
            fontSize: ScreenAdapter.getFontSize(12),
          ),
          selectedLabelStyle: TextStyles.commTextStyle().copyWith(
              color: AppColor.color_55D180,
              fontSize: ScreenAdapter.getFontSize(12)),
          type: BottomNavigationBarType.fixed,
          iconSize: ScreenAdapter.getFontSize(24),
          items: bottomBarItems,
          currentIndex: _tabIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }

  // 双击返回键退出应用
  Future<bool> _doubleExit() {
    int nowTime = DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return Future.value(true);
    } else {
      _lastClickTime = DateTime.now().microsecondsSinceEpoch;
      Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      ToastUtil.showToastForShort("再按一次退出应用", gravity: ToastGravity.BOTTOM);
      return Future.value(false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
}
