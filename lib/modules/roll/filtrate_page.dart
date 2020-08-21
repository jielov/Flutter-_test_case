import 'package:flutter/material.dart';
import 'package:videotest/view/base_app_bar.dart';

class Switchover extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: '图片滑动',
        automaticallyImplyLeading: true,
      ).commAppBar(context),
      body: DisplayPage(),
    );
  }
}

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => new _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  static bool _isAddGradient = false;

  final List descriptions = [
    'tryenough.com',
    'tryenough.com',
    'tryenough.com',
  ];

  var decorationBox = DecoratedBox(
    decoration: _isAddGradient
        ? BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomRight,
              end: FractionalOffset.topLeft,
              colors: [
                Color(0x00000000).withOpacity(0.9),
                Color(0xff000000).withOpacity(0.01),
              ],
            ),
          )
        : BoxDecoration(),
  );

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 0.8);

    controller.addListener(() {});

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(550.0),
          child: PageView.builder(
            controller: controller,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.deepOrangeAccent,
                      duration: Duration(milliseconds: 800),
                      content: Center(
                        child: Text(
                          descriptions[index],
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FlutterLogo(
                            style: FlutterLogoStyle.stacked,
                            colors: Colors.red),
                        decorationBox,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
