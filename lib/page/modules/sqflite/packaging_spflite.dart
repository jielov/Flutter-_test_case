import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class PackagingSpflite extends StatefulWidget {
  @override
  _PackagingSpfliteState createState() => _PackagingSpfliteState();
}

class _PackagingSpfliteState extends State<PackagingSpflite> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String _data = "暂无数据";
  String _dbName = 'user.db'; // 数据库名称

  String _createTableSQL =
      'CREATE TABLE student_table (id INTEGER PRIMARY KEY, name TEXT,age INTEGER)'; //创建学生表;
  int _dbVersion = 1; //数据版本

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createDb(_dbName, _dbVersion, _createTableSQL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('数据库操作'),
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
            Text(_data),
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
      onPressed: () {
        if (_nameController.text == null || _nameController.text == "") {
          Fluttertoast.showToast(msg: "插入数据不能为空！", backgroundColor: Colors.red);
          return;
        }
        if (_ageController.text == null || _ageController.text == "") {
          Fluttertoast.showToast(msg: "插入数据不能为空", backgroundColor: Colors.red);
          return;
        }
        String sql =
            "INSERT INTO student_table(name,age) VALUES('${_nameController.text}','${_ageController.text}')";
        _add(_dbName, sql);
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

  _getdeleteBtnView() {
    return RaisedButton(
      onPressed: () {
        String sql = "DELETE FROM student_table"; //无条件删除数据
        _delete(_dbName, sql);
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
        String sql = "UPDATE student_table SET name =? WHERE id = ?";
        _update(_dbName, sql, [_nameController.text, 1]);
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
        String sql = 'SELECT * FROM student_table';
        _query(_dbName, sql);
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

  ///创建数据库db
  _createDb(String dbName, int vers, String dbTables) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    print("数据库路径： $path, 数据库版本： $vers");
    //打开数据库
    await openDatabase(path, version: vers,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //数据库升级,只回调一次
      print("数据库需要升级！旧版：$oldVersion,新版：$newVersion");
    }, onCreate: (Database db, int vers) async {
      //创建表，只回调一次
      await db.execute(dbTables);
      await db.close();
    });
    setState(() {
      _data = "成功创建数据库db！\n 数据库路径： $path \n 数据库版本 $vers";
    });
  }

  //增
  _add(String dbName, String sql) async {
    //获取数据库路径
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    print("数据库路径: $path");

    Database db = await openDatabase(path);
    await db.transaction((txn) async {
      int count = await txn.rawInsert(sql);
    });
    await db.close();
    setState(() {
      _data = "插入数据库成功";
    });
  }

  //删
  _delete(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawDelete(sql);
    await db.close();

    if (count > 0) {
      setState(() {
        _data = "执行收藏操作完成，该sql删除条件下的数目为：$count";
      });
    } else {
      setState(() {
        _data = "无法执行删除操作，该sql删除条件下的数目为：$count";
      });
    }
  }

  // 改
  _update(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = await db.rawUpdate(sql, arg); //修改条件，对应参数值
    await db.close();
    if (count > 0) {
      setState(() {
        _data = "更新数据库操作完成：$count";
      });
    } else {
      setState(() {
        _data = "无法更新数据库：$count";
      });
    }
  }

  //查条数
  _getQueryNum(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    int count = Sqflite.firstIntValue(await db.rawQuery(sql));
    await db.close();
    return count;
  }

  ///查全部
  _query(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    Database db = await openDatabase(path);
    List<Map> list = await db.rawQuery(sql);
    await db.close();
    setState(() {
      _data = "数据详情： $list";
    });
  }
}
