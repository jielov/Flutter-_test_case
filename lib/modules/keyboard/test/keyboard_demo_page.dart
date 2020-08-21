
import 'package:flutter/material.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/res/styles.dart';
import 'package:videotest/utils/adapter.dart';

class InputBottomDemoPage extends StatefulWidget {
  @override
  _InputBottomDemoPageState createState() => _InputBottomDemoPageState();
}

class _InputBottomDemoPageState extends State<InputBottomDemoPage> {
  List<String> feedbackBuList = ['功能建议', '性能问题'];
  int feedbackIndex = 0;

  static final TextEditingController textContent = TextEditingController();
  static final TextEditingController contentWay = TextEditingController();
  bool isKeyboardShowing = false;

  @override
  Widget build(BuildContext context) {
    ///必须嵌套在外层
    return KeyboardDetector(
      keyboardShowCallback: (show) {
        setState(() {
          isKeyboardShowing = show;
        });
      },
      content: Scaffold(
        appBar: AppBar(
          title: new Text("KeyBoardDemoPage"),
        ),
        body: new GestureDetector(
          ///透明可以触摸
          behavior: HitTestBehavior.translucent,
          onTap: () {
            /// 触摸收起键盘
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '分类标签',
                style: TextStyles.commTextStyle().copyWith(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: ScreenAdapter.getHeight(10),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.all(10),
                height: ScreenAdapter.getHeight(60),
                child: _classifyButton(),
              ),
              SizedBox(
                height: ScreenAdapter.getHeight(10),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        '反馈内容',
                        style: TextStyles.commTextStyle().copyWith(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: ScreenAdapter.getHeight(10),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: _textContent(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: ScreenAdapter.getHeight(10),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '联系方式',
                      style: TextStyles.commTextStyle().copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: ScreenAdapter.getHeight(10),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: _contentWay(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenAdapter.getHeight(10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///分类标签
  _classifyButton() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: feedbackBuList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              feedbackIndex = index;
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                width: ScreenAdapter.getWidth(1),
                color: feedbackIndex == index
                    ? AppColor.color_0BB4E4
                    : AppColor.color_DDDDDD,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(ScreenAdapter.getWidth(2.5))),
              color: AppColor.color_DDDDDD,
            ),
            child: Text(
              feedbackBuList[index],
              style: TextStyles.commTextStyle().copyWith(
                fontSize: 15,
                color: feedbackIndex == index
                    ? AppColor.color_0BB4E4
                    : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  _textContent() {
    return TextField(
      controller: textContent,
      maxLines: 6,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: ScreenAdapter.getHeight(10),
          left: ScreenAdapter.getHeight(10),
        ),
        hintText: '请输入反馈内容',
        border: InputBorder.none,
      ),
      maxLength: 200,
    );
  }

  _contentWay() {
    return TextFormField(
      controller: contentWay,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          left: ScreenAdapter.getHeight(10),
        ),
        hintText: '请输入邮箱或电话',
        border: InputBorder.none,
      ),
      onSaved: (String value) {
        //TODO
      },
    );
  }
}

typedef KeyboardShowCallback = void Function(bool isKeyboardShowing);

///监听键盘弹出收起
class KeyboardDetector extends StatefulWidget {
  final KeyboardShowCallback keyboardShowCallback;

  final Widget content;

  KeyboardDetector({this.keyboardShowCallback, @required this.content});

  @override
  _KeyboardDetectorState createState() => _KeyboardDetectorState();
}

class _KeyboardDetectorState extends State<KeyboardDetector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        widget.keyboardShowCallback
            ?.call(MediaQuery.of(context).viewInsets.bottom > 0);
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.content;
  }
}
