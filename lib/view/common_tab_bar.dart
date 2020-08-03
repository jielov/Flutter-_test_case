
import 'package:flutter/material.dart';
import 'package:videotest/res/dimens.dart';
import 'package:videotest/res/styles.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:videotest/view/under_line_tab_indicator.dart';

class CommonTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final TabController tabController;
  final bool isScrollable;

  CommonTabBar(
      {Key key,
      @required this.tabTitles,
      @required this.tabController,
      this.isScrollable: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.tabBarHeight,
      child: TabBar(
        tabs: tabTitles.map((title) {
          return Text(title);
        }).toList(),
        indicator: RoundUnderlineTabIndicator(
            borderSide: BorderSide(
          width: ScreenAdapter.getWidth(3),
        )),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: isScrollable,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        labelPadding:
            EdgeInsets.symmetric(horizontal: ScreenAdapter.getWidth(10)),
        indicatorPadding: EdgeInsets.zero,
        unselectedLabelStyle: TextStyles.commTextStyle().copyWith(
          fontSize: ScreenAdapter.getFontSize(14),
        ),
        labelStyle: TextStyles.commBoldTextStyle()
            .copyWith(fontSize: ScreenAdapter.getFontSize(18)),
      ),
    );
  }
}
