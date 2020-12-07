import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends StatefulWidget {
  @override
  _LocalStorageState createState() => new _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  //存储本地数据
  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", "哈利波特");
    print("存储成功");
  }

  //获取本地数据
  void getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("本地存储"),
        ),
        body: SingleChildScrollView(
          child: Wrap(
            children: [
              RaisedButton(
                onPressed: () => save(),
                child: Text("本地存储"),
              ),
              RaisedButton(
                onPressed: () => getLocalData(),
                child: Text("获取本地存储数据"),
              )
            ],
          ),
        ));
  }
}
