import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestPageState();
  }
}

class _TestPageState extends BoardWidget {
  final bool _useSystemKeyBoard = true;

  final TextStyle textStyle = TextStyle(
      fontFamily: "hwxw",
      fontSize: 20.0,
      letterSpacing: 1.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black87);

  final TextStyle lableStyle = TextStyle(
      fontFamily: "hwxw",
      fontSize: 20.0,
      letterSpacing: 16.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal);

  final TextStyle helperStyle = TextStyle(
      fontFamily: "hwxw", fontSize: 12.0, fontStyle: FontStyle.normal);

  ScrollFocusNode _userNameFocusNode;
  ScrollFocusNode _passWordFocusNode;

  @override
  void initState() {
    super.initState();
    _userNameFocusNode = ScrollFocusNode(_useSystemKeyBoard, 120.0); // 第二个参数是向上滚动的距离
    _passWordFocusNode = ScrollFocusNode(_useSystemKeyBoard, 180.0); // 第二个参数是向上滚动的距离
  }

  @override
  List<Widget> initChild() {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 350.0, left: 50.0, right: 50.0),
        child: TextField(
          focusNode: _userNameFocusNode,
          autofocus: false,
          maxLength: 12,
          maxLines: 1,
          style: textStyle,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            border: OutlineInputBorder(),
            labelText: "账号",
            labelStyle: lableStyle,
            helperStyle: helperStyle,
            prefixIcon: Icon(Icons.account_box, size: 24.0),
          ),
          onTap: () {
            // 点击时绑定当前focusNode
            bindNewInputer(_userNameFocusNode);
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0),
        child: TextField(
          obscureText: true,
          focusNode: _passWordFocusNode,
          autofocus: false,
          maxLength: 12,
          maxLines: 1,
          style: textStyle,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            border: OutlineInputBorder(),
            labelText: "密码",
            labelStyle: lableStyle,
            helperStyle: helperStyle,
            prefixIcon: Icon(Icons.https, size: 24.0),
          ),
          onTap: () {
            // 点击时绑定当前focusNode
            bindNewInputer(_passWordFocusNode);
          },
        ),
      ),
    ];
  }
}

class ScrollFocusNode extends FocusNode {
  final bool _useSystemKeyBoard; // 是否使用系统键盘
  final double _moveValue; // 上移距离

  ScrollFocusNode(this._useSystemKeyBoard, this._moveValue);

  @override
  bool consumeKeyboardToken() {
    if (_useSystemKeyBoard) {
      return super.consumeKeyboardToken();
    }
    return false;
  }

  double get moveValue => _moveValue;

  bool get useSystemKeyBoard => _useSystemKeyBoard;
}

abstract class BoardWidget extends State<StatefulWidget>
    with WidgetsBindingObserver {
  final ScrollController _controller = ScrollController();

  ScrollFocusNode _focusNode;

  double _currentPosition = 0.0;

  List<Widget> initChild();

  void bindNewInputer(ScrollFocusNode focusNode) {
    _focusNode = focusNode;
    _animateUp();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  //  向上滚动
  void _animateUp() {
    _controller
        .animateTo(_focusNode.moveValue,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut)
        .then((Null) {
      _currentPosition = _controller.offset;
    });
  }

  //  向下滚动
  void _animateDown() {
    _controller
        .animateTo(0.0,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut)
        .then((Null) {
      _currentPosition = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: initChild()..add(SizedBox(height: 400.0)),
        ),
      ),
    );
  }

  //  使用系统键盘 ---> 矩阵变换 ---> 返回原位置
  @override
  void didChangeMetrics() {
    if (_currentPosition != 0.0) {
      _focusNode.unfocus(); // 如果不加，收起键盘再点击会默认键盘还在。
      _animateDown();
    }
  }
}