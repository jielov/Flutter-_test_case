import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';
import 'package:videotest/utils/adapter.dart';

class DownFilePage extends StatefulWidget {
  final String title;
  final String url; //下载地址
  final String fileName; //下载地址
  final String fileHouZHui; //下载地址
  final String isSystemDown; //是否使用调用系统的下载器，true是，false否 使用flutter的下载器
  final ValueChanged<int> progressValueChanged;

  const DownFilePage(
      {Key key,
      this.title,
      this.url,
      this.fileName,
      this.fileHouZHui,
      this.isSystemDown,
      this.progressValueChanged})
      : super(key: key);

  _DownloaderPageState createState() {
    return _DownloaderPageState();
  }
}

class _DownloaderPageState extends State<DownFilePage> {
  //下载
  ProgressDialog pro;
  String _loCaPath = "";
  String _url = "https://modelimg.cjmx.com/upload/2006/01/010835448.mp4";
  ReceivePort _port = ReceivePort();

  //播放
  VideoPlayerController _controller;
  Future _initializeVideo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //下载
    if (widget.url != null && widget.url != "") {
      _url = widget.url;
    }
    WidgetsFlutterBinding.ensureInitialized();
    //初始化FlutterDownloader
    FlutterDownloader.initialize().then((v) {
      init();
    });
    //播放
    _controller = VideoPlayerController.network(_url);
    _controller.setLooping(true);
    _initializeVideo = _controller.initialize();
    //启动页面播放视频
    _controller.play();
  }

  init() async {
    if (await _checkPermission()) {
      //获取路径
      _loCaPath = await _findLocalPath();
      // 初始化进度条
      IsolateNameServer.registerPortWithName(
          _port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) {
        String id = data[0];
        DownloadTaskStatus status = data[1];
        print(data[2].toString());
        if (status.value.toString() == "2") {
          print('下载中');
          pro.update(progress: 0.0, message: "下载中");
        }
        if (status.value.toString() == "3") {
          print("下载完成");
          pro.update(progress: 0.0, message: "下载完成");
        }
      });
      FlutterDownloader.registerCallback(downloadCallack);
    } else {
      Toast.show("没有栖息，请打开存储权限", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    pro = ProgressDialog(context,
        type: ProgressDialogType.Download,
        isDismissible: false,
        showLogs: false);
    pro.update(progress: 0.0, message: "下载中...");

    return Scaffold(
      appBar: AppBar(
        title: Text('视频播放下载'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            //视频播放
            FutureBuilder(
                future: _initializeVideo,
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.hasError) print(snapshot.error);
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
//                      aspectRatio: 16 / 9,
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            SizedBox(
              height: ScreenAdapter.getHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //播放按钮
                RaisedButton(
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                ),
                SizedBox(
                  width: ScreenAdapter.getWidth(30),
                ),
                //下载按钮
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('下载视频'),
                  onPressed: () {
                    // 执行下载操作
                    _doDownload();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //文件下载
  _doDownload() {
    _downloadFile(
      downloadUrl: _url,
      savePath: _loCaPath,
    );
  }

  // 判断是否拿到权限
  Future<bool> _checkPermission() async {
    // 先对所在平台进行判断
    if (Theme.of(context).platform == TargetPlatform.android) {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

// 获取存储路径
  Future<String> _findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    // androidPath 用于存储安卓段的路径
    String androidPath = "";
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory().then((f) {
            print(f.path);
            androidPath = f.path + "/download";
          })
        : await getApplicationDocumentsDirectory();
    //判断androidPath是否为空 为空返回ios的路径 否则 返回android的路径
    if (androidPath != "") {
      final savedDir = Directory(androidPath);
      // 判断下载路径是否存在
      bool heasExisted = await savedDir.exists();
      // 不存在就新建路径
      if (!heasExisted) {
        savedDir.create();
      }
      return androidPath;
    } else {
      return directory.path;
    }
  }

  // 根据 downloadUrl 和 savePath 下载文件
  _downloadFile({downloadUrl, savePath}) async {
    debugPrint("下载路径" + savePath);
    await FlutterDownloader.enqueue(
        url: downloadUrl,
        savedDir: savePath,
        showNotification: true,
        openFileFromNotification: true);
  }

  // 根据taskId打开下载文件
  Future<bool> _openDownloadedFile(taskId) {
    return FlutterDownloader.open(taskId: taskId);
  }

  static void downloadCallack(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void dispose() {
    // TODO: implement dispose
    IsolateNameServer.removePortNameMapping("downloader_send_port");
    _controller.dispose();
    super.dispose();
  }
}
