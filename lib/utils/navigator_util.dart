import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtil {


//  /// 验证码页面
//  static Future<bool> toVerifyPage(BuildContext context,
//      {@required String phone, @required bool isRegister}) async {
//    return await navigatorRouter(
//      context,
//      VerifyPage(
//        phone: phone,
//        isRegister: isRegister,
//      ),
//    );
//  }




//  ///仓库版本列表
//  static Future goReleasePage(BuildContext context, String userName,
//      String reposName, String releaseUrl, String tagUrl) {
//    return NavigatorRouter(
//        context,
//        new ReleasePage(
//          userName,
//          reposName,
//          releaseUrl,
//          tagUrl,
//        ));
//  }

  ///公共打开方式
  static navigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context,
        CupertinoPageRoute(builder: (context) => pageContainer(widget)));
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget) {
    return MediaQuery(

        ///不受系统字体缩放影响
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .copyWith(textScaleFactor: 1),
        child: widget);
  }




}
