
import 'package:flutter/material.dart';
import 'file:///E:/AndroidStudio/XMU/video_test/lib/page/modules/discover_dome/right_lIst_view.dart';
import 'package:videotest/utils/adapter.dart';
import 'package:videotest/view/base_app_bar.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  List<String> leftList = [
    '范文',
    '生活',
    '时空',
    '零食',
    '历史',
    '文明',
    '美照',
    '世界',
    '武库',
    '一切',
    '善意',
    '人民',
    '至高',
  ];
  int _selectCount = 0;
  void Function(int) onMenuChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onMenuChecked = (int i) {
      if (_selectCount != i) {
        _selectCount = i;
      }
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        titleStr: '发现之左侧选择列表',
        automaticallyImplyLeading: true,
      ).commAppBar(context),
      body: Row(
        children: <Widget>[
          leftListtv(3, leftList, onMenuChecked),
          Image.asset('assets/images/icon_bar_back.png'),
          Expanded(
            flex: 7,
            child: RightLIstView(),
          ),
        ],
      ),
    );
  }

  Widget leftListtv(int i, List<String> myContent, onMenCheckListener) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          itemCount: leftList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                onMenCheckListener(index);
              },
              child: Container(
                margin: EdgeInsets.all(3),
                padding: EdgeInsets.only(
                  top: ScreenAdapter.getHeight(10),
                  bottom: ScreenAdapter.getHeight(10),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: _selectCount == index
                          ? Colors.redAccent
                          : Colors.white,
                      width: ScreenAdapter.getWidth(0.5)),
                ),
                alignment: Alignment.center,
                child: Text(
                  leftList[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenAdapter.getFontSize(16),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
