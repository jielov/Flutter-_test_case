
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videotest/utils/adapter.dart';

class DataStorePage extends StatefulWidget {
  @override
  _DataStorePageState createState() => _DataStorePageState();
}

class _DataStorePageState extends State<DataStorePage> {
  final String mUserName = "UserName";
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    save() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(mUserName, _userNameController.value.text.toString());
    }

    Future<String> get() async {
      var userName;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      userName = prefs.getString(mUserName);
      return userName;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("数据存储之shared_preferences"),
      ),
      body: Center(
        child: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    top: ScreenAdapter.getHeight(20),
                  ),
                  icon: Icon(Icons.perm_identity),
                  labelText: "请输入用户名",
                  hintText: "注册时填写的名字",
                ),
              ),
              RaisedButton(
                color: Colors.redAccent,
                child: Text('存储'),
                onPressed: () {
                  save();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('数据存储成功'),
                  ));
                },
              ),
              RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text('获取'),
                  onPressed: () {
                    Future<String> userName = get();
                    userName.then((String userName) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '数据获取成功： $userName',
                          ),
                        ),
                      );
                    });
                  })
            ],
          );
        }),
      ),
    );
  }
}
