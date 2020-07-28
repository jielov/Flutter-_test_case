import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_app/utils/CXColors.dart';

class DropDownSelect extends StatelessWidget {
  final String label;
  String value;
  final List<DropdownMenuItem> items;
  final ValueChanged onChanged;
  bool isText;

  DropDownSelect({Key key, this.label, this.value, this.items, this.onChanged, this.isText = false});

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 40.0,
      padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
      decoration: new BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.tealAccent, width: 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          new Expanded(
//            flex: 3,
            child: new Container(
              child: new Text(
                this.label,
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
            ),
          ),
          new Expanded(
//            flex: 8,
            child: Container(
              padding: EdgeInsets.only(top: 4.0),
              child: this.isText ? Text(this.value) : DropdownButton(
                icon: Icon(
                  Icons.arrow_downward,
                  color: Colors.black26,
                ),
                style: TextStyle(fontSize: 15.0, color: Colors.black54),
                iconSize: 22.0,
                isExpanded: false,
                underline: new Container(),
                hint: Text('请选择',
                  style: TextStyle(
                      color: Colors.black26
                  ),
                ),
                items: this.items,
                onChanged: onChanged,
                value: this.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}