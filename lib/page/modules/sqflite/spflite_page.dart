import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/sqflite/DBUtil.dart';
import 'package:videotest/sqflite/TablesInit.dart';
import 'package:videotest/utils/adapter.dart';

class SpflitePage extends StatefulWidget {
  @override
  _SpflitePageState createState() => _SpflitePageState();
}

class _SpflitePageState extends State<SpflitePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  DBUtil dbUtil = null;

  var dataList = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqlData();
  }

  // 初始化数据库
  Future sqlData() async {
    TablesInit tables = TablesInit();
    tables.init();
    dbUtil = DBUtil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('封装数据库工具类'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                '设置进入程序默认创建数据库和一张学生表，如下可对表的姓名、年龄进行增删改查操作：',
                style: TextStyle(
                  fontSize: ScreenAdapter.getFontSize(13),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.getHeight(10),
            ),
            _getNameInputView(),
            SizedBox(
              height: ScreenAdapter.getHeight(10),
            ),
            _geAgeInputView(),
            SizedBox(
              height: ScreenAdapter.getHeight(20),
            ),
            _getAddBtnView(),
            _getdeleteBtnView(),
            _getUpdateBtnView(),
            _getQueryBtnView(),
            SizedBox(
              height: ScreenAdapter.getHeight(20),
            ),
            Text(dataList),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  _getNameInputView() {
    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyle(color: AppColor.color_888888),
      controller: _nameController,
      decoration: InputDecoration(
        hintText: "姓名：",
        hintStyle: TextStyle(color: AppColor.color_888888),
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  _geAgeInputView() {
    return TextField(
      keyboardType: TextInputType.text,
      style: TextStyle(color: AppColor.color_888888),
      controller: _ageController,
      decoration: InputDecoration(
        hintText: '年龄',
        hintStyle: TextStyle(color: AppColor.color_888888),
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  _getAddBtnView() {
    return RaisedButton(
      onPressed: () async {
        if (_nameController.text == null || _nameController.text == "") {
          Fluttertoast.showToast(msg: "插入数据不能为空！", backgroundColor: Colors.red);
          return;
        }
        if (_ageController.text == null || _ageController.text == "") {
          Fluttertoast.showToast(msg: "插入数据不能为空", backgroundColor: Colors.red);
          return;
        }
        insertData();
      },
      child: Text(
        '插入数据',
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenAdapter.getFontSize(15),
        ),
      ),
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  //插入
  void insertData() async {
    await dbUtil.open();
    Map<String, Object> par = Map<String, Object>();
    par['uid'] = '${_nameController.text}';
    par['fuid'] = '${_ageController.text}';
    par['type'] = Random().nextInt(2);
    int flag = await dbUtil.insertByHelper('relation', par);
    //int flag = await dbUtil.insert('INSERT INTO relation(uid, fuid, type) VALUES("111111", "2222222", 1)');
    print('flag:$flag');
    await dbUtil.close();
    queryData();
  }

  _getdeleteBtnView() {
    return RaisedButton(
      onPressed: () async {
        await dbUtil.open();
        dbUtil.delete('DELETE FROM relation', null);
        await dbUtil.close();
        queryData();
        Fluttertoast.showToast(
            msg: "删除数据成功", backgroundColor: Colors.cyanAccent);
      },
      color: Colors.red,
      child: Text(
        "删除数据",
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenAdapter.getFontSize(15),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  _getUpdateBtnView() {
    return RaisedButton(
      onPressed: () {
        if (_nameController.text == null || _nameController.text == "") {
          Fluttertoast.showToast(msg: "姓名不能为空", backgroundColor: Colors.red);
          return;
        }
//        String sql = "UPDATE student_table SET name =? WHERE id = ?";
//        _update(_dbName, sql, [_nameController.text, 1]);
      },
      child: Text(
        "修改姓名",
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenAdapter.getFontSize(15),
        ),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  _getQueryBtnView() {
    return RaisedButton(
      onPressed: () {
        queryData();
      },
      child: Text(
        '查询数据',
        style: TextStyle(
            color: Colors.white, fontSize: ScreenAdapter.getFontSize(15)),
      ),
      color: Colors.purpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  //查询
  void queryData() async {
    await dbUtil.open();
    List<Map> data = await dbUtil.queryList("SELECT * FROM relation");
    //List<Map> data = await dbUtil.queryListByHelper('relation', ['id','uid','fuid','type'], 'uid=?', [5]);
    print('data：$data');
    String showdata = "";
    if (data == null) {
      showdata = "";
    } else {
      showdata = data.toString();
    }
    setState(() {
      dataList = showdata;
    });
    await dbUtil.close();
  }
}
