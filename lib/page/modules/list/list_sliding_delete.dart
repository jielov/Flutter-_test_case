
import 'package:flutter/material.dart';


//列表左右滑动删除
class ListSlidingDelete extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表左右滑动删除'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            onDismissed: (_) {
              //参数暂时没有用到，则用下划线表示
              print("--removeAt---" + index.toString());
              items.removeAt(index);
            },
            // 监听
            movementDuration: Duration(milliseconds: 100),
            key: Key(item),
            child: ListTile(
              title: Text('$item'),
            ),
            background: Container(
              color: Color(0xffff0000),
            ),
          );
        },
      ),
    );
  }
}
