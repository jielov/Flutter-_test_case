import 'package:flutter/material.dart';

const double _ITEM_HEIGHT = 70.0;

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => new _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Item> _items;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _items = new List<Item>();
    _items.add(new Item('詹姆斯', false));
    _items.add(new Item('杜兰特', false));
    _items.add(new Item('库里', false));
    _items.add(new Item('哈登', false));
    _items.add(new Item('威少', false));
    _items.add(new Item('欧文', false));
    _items.add(new Item('戴维斯', false));
    _items.add(new Item('汤神', false));
    _items.add(new Item('格林', false));
    _items.add(new Item('恩比德', false));
    _items.add(new Item('保罗', false));
    _items.add(new Item('乔丹', false));
    _items.add(new Item('莱昂纳德', false));
    _items.add(new Item('塔图姆', false));
    _items.add(new Item('利拉德', false));
    _items.add(new Item('乐福', false));
    _items.add(new Item('科比', false));
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonsWidget = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child: new Text('杜兰特'),
            onPressed: _scrollToKd,
          ),
          new FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child: new Text('科比'),
            onPressed: _scrollToKobe,
          ),
        ],
      ),
    );

    Widget itemsWidget = new ListView(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        shrinkWrap: true,
        children: _items.map((Item item) {
          return _singleItemDisplay(item);
        }).toList());

    for (int i = 0; i < _items.length; i++) {
      if (_items.elementAt(i).selected) {
        _scrollController.animateTo(i * _ITEM_HEIGHT,
            duration: new Duration(seconds: 2), curve: Curves.ease);
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("flutter之滚动到列表指定item位置教程"),
      ),
      body: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: new Column(
          children: <Widget>[
            buttonsWidget,
            new Expanded(
              child: itemsWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleItemDisplay(Item item) {
    return new Container(
      height: _ITEM_HEIGHT,
      child: new Container(
        padding: const EdgeInsets.all(2.0),
        color: new Color(0x33000000),
        child: new Text(item.displayName),
      ),
    );
  }

  void _scrollToKd() {
    // TODO
    setState(() {
      for (var item in _items) {
        if (item.displayName == '杜兰特') {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
    });
  }

  void _scrollToKobe() {
    // TODO
    setState(() {
      for (var item in _items) {
        if (item.displayName == '科比') {
          item.selected = true;
        } else {
          item.selected = false;
        }
      }
    });
  }
}

class Item {
  final String displayName;
  bool selected;

  Item(this.displayName, this.selected);
//  const Item(this.displayName);

}
