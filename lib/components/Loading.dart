import 'package:flutter/material.dart';

/**
 * loading
 * 
 * 使用方法：
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
 */
class Loading extends StatefulWidget {
  Loading({Key key, this.text = "加载中"}) : super(key: key);
  final String text;

  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<Loading> {
  RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)));

  @override
  void initState() {
    super.initState();
    print(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 120,
      height: 120,
      child: Material(
        elevation: 24.0,
        color: Theme.of(context).dialogBackgroundColor,
        type: MaterialType.card,
        //在这里修改成我们想要显示的widget就行了，外部的属性跟其他Dialog保持一致
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: new Text(widget.text),
            ),
          ],
        ),
        shape: _defaultDialogShape,
      ),
    ));
  }
}
