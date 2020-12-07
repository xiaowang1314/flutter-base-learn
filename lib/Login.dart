import 'package:flutter/material.dart';
import 'models/TokenInfo.dart';
import 'models/common/ResponseData.dart';
import 'utils/ColorsUtil.dart';
import './utils/Ajax.dart';
import 'components/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  int tabIndex = 1;
  bool _isButtonDisabled = false; //是否禁用按钮

  TextEditingController _telController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", "哈利波特12");
    print("存储成功");
  }

  void toLogin() async {
    setState(() {
      _isButtonDisabled = true;
    });
    try {
      Ajax ajax = new Ajax();
      ajax.get(
          url: '/auth/agentLogin',
          params: {
            "phone": "18327519799",
            "password": "wz123456",
            "company_id": "2",
            "type": 2
          },
          callback: (data) {
            var res = ResponseData<TokenInfo>.fromJson(data);
            // print(res.data.token);
            if (res.code == 1) {
              save();
              setState(() {
                _isButtonDisabled = false;
              });
              Navigator.popAndPushNamed(context, "home");
            }
          });

      // Response response = await Dio().get(
      //     "http://webapi.wanzhuang-app.com/auth/agentLogin?password=wz123456&company_id=2&phone=18327519799&type=2");
      // Map data = jsonDecode(response.toString());
      // var res = User.fromJson(data);
      // if (res.code == 1) {
      //   setState(() {
      //     _isButtonDisabled = false;
      //   });
      //   Navigator.popAndPushNamed(context, "home");
      // }
      // print(res.data.token);
    } catch (e) {
      print(e);
    }
  }

  void tabChange(index) {
    setState(() => {tabIndex = index});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        backgroundColor: ColorsUtil.hexColor(0x1da57a),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Image.network(
                "https://frontend-c.oss-cn-hangzhou.aliyuncs.com/wz-agent/img/SignBg.png",
                width: MediaQuery.of(context).size.width - 30,
                height: 245,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _telController, //设置controller
                    autofocus: false,
                    onChanged: (v) {
                      print(_telController.text);
                    },
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      labelText: "手机号",
                      hintText: "请输入手机号",
                      prefixIcon: Icon(Icons.phone),
                      prefixStyle: TextStyle(color: Colors.red),
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorsUtil.hexColor(0xd9d9d9)),
                      ),
                      //获得焦点下划线设为蓝色
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorsUtil.hexColor(0x1da57a)),
                      ),
                    ),
                  ),
                  TextField(
                      controller: _pwdController, //设置controller
                      onChanged: (v) {
                        print(_pwdController.text);
                      },
                      obscureText: true,
                      autofocus: false,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "请输入密码",
                          prefixIcon: Icon(Icons.lock),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsUtil.hexColor(0xd9d9d9))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorsUtil.hexColor(0x1da57a)))))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: ColorsUtil.hexColor(0x1da57a),
                  onPressed: _isButtonDisabled ? null : toLogin,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text("登录",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
