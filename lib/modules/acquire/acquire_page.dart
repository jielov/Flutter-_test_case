import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path_provider_ex/path_provider_ex.dart';


class AcquirePage extends StatefulWidget {
  @override
  _AcquirePageState createState() => _AcquirePageState();
}

class _AcquirePageState extends State<AcquirePage> {
  List<StorageInfo> _storageInfo = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List<StorageInfo> storageInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      storageInfo = await PathProviderEx.getStorageInfo();
    } on PlatformException {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _storageInfo = storageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                '内部存储根:\n ${(_storageInfo.length > 0) ? _storageInfo[0].rootDir : "unavailable"}\n'),
            Text(
                '内部存储appFilesDir:\n ${(_storageInfo.length > 0) ? _storageInfo[0].appFilesDir : "unavailable"}\n'),
            Text(
                '内部存储AvailableGB:\n ${(_storageInfo.length > 0) ? _storageInfo[0].availableGB : "unavailable"}\n'),
            Text(
                'SD Card root: ${(_storageInfo.length > 1) ? _storageInfo[1].rootDir : "unavailable"}\n'),
            Text(
                'SD Card appFilesDir: ${(_storageInfo.length > 1) ? _storageInfo[1].appFilesDir : "unavailable"}\n'),
            Text(
                'SD Card AvailableGB:\n ${(_storageInfo.length > 1) ? _storageInfo[1].availableGB : "unavailable"}\n'),
          ],
        ) ,
      ),
    );
  }
}