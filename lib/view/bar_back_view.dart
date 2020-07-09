import 'package:flutter/material.dart';
import 'package:videotest/res/dimens.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:videotest/utils/image_utils.dart';

class BarBackView extends StatelessWidget {
  final bool isWhite;
  final Function onBack;
  final double paddingLeft;
  final double paddingRight;
  final double height;

  const BarBackView(
      {Key key,
      this.isWhite = false,
      this.onBack,
      this.paddingLeft,
      this.paddingRight,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onBack != null) {
          onBack();
        }
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: height ?? ScreenAdapter.getHeight(Dimens.appBarHeight),
        child: UnconstrainedBox(
          child: Container(
            padding: EdgeInsets.only(
                left: paddingLeft ?? ScreenAdapter.getWidth(12.5),
                right: paddingRight ?? ScreenAdapter.getWidth(12)),
            child: Image.asset(
              ImageUtils.getPNGImagePath(
                  isWhite ? "icon_bar_back" : "icon_bar_black_back"),
              height: ScreenAdapter.getHeight(15),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
//    return IconButton(
//      icon: Icon(Icons.arrow_back_ios),
//      color: isWhite ? Colors.white : AppColor.color_333333,
//      iconSize: ScreenAdapter.getHeight(18),
//      onPressed: () {
//        if (onBack != null) {
//          onBack();
//        }else if (Navigator.canPop(context)) {
//          Navigator.pop(context);
//        }
//      },
//    );
  }
}
