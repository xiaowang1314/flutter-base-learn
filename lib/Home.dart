import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/Loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  _launchURL() async {
    const url = 'https://agent-dev.wanzhuang-app.com/c/2';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)));

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", "哈利波特");
    print("存储成功");
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              onPressed: _launchURL,
              child: Text("订单"),
            ),
            RaisedButton(
              onPressed: save,
              child: Text("本地保存"),
            ),
            RaisedButton(
              onPressed: getData,
              child: Text("获取本地存储数据"),
            ),
            RaisedButton(
              onPressed: () => {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      Timer(Duration(seconds: 3),
                          () => {Navigator.of(context).pop()});
                      return Loading(
                        text: "登录中",
                      );
                    })
              },
              child: Text("测试弹窗"),
            ),
          ],
        ),
      ),
    );
  }
}
