import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class PopUpWindows extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter之Hero动画',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showPhoto(BuildContext context, Widget image) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
          return GestureDetector(
            child: SizedBox.expand(
              child: Hero(
                tag: image,
                child: image,
              ),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          );
        }));
  }

  List<Widget> _list = <Widget>[
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: Image.asset(
        'images/hanyun.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('flutter展示底部弹窗'),
          centerTitle: true,
        ),
        body: Center(
          child: RaisedButton(
            child: const Text('展示底部弹窗'),
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        padding: const EdgeInsets.all(4.0),
                        children: _list.map(
                              (Widget img) {
                            return GestureDetector(
                              onTap: () {
                                showPhoto(context, img);
                              },
                              child: Hero(
                                tag: img,
                                child: img,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  });
            },
          ),
        ));
  }
}