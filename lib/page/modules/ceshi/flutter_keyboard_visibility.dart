import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';



class CeShi extends StatefulWidget {
  CeShi({Key key}) : super(key: key);

  @override
  _CeShiState createState() => _CeShiState();
}

class _CeShiState extends State<CeShi> {
  bool _keyboardState;

  @override
  void initState() {
    super.initState();
    _keyboardState = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        _keyboardState = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardDismissOnTap(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Keyboard Visibility Example'),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Input box for keyboard test',
                    ),
                  ),
                  Container(height: 90.0),
                  Text(
                    'The keyboard is: ${_keyboardState ? 'VISIBLE' : 'NOT VISIBLE'}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
