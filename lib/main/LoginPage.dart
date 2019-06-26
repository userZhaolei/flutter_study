import 'package:flutter/material.dart';
import 'package:flutter_study/main/HomePage.dart';
import 'package:flutter_study/main/MainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(primarySwatch: Colors.red),
      home: new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "登录",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: _login(),
      ),
    );
  }

  var _userNameController = TextEditingController();
  var _userPwdController = TextEditingController();

  Widget _login() {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text("Flutter",
                style: TextStyle(color: Colors.red, fontSize: 18))),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: TextField(
            controller: _userNameController,
            decoration: InputDecoration(
                labelText: '请输入您的账号', icon: Icon(Icons.account_circle)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12, 15, 12, 0),
          child: TextField(
            controller: _userPwdController,
            decoration:
                InputDecoration(labelText: '请输入您的密码', icon: Icon(Icons.lock)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: MaterialButton(
            onPressed: () {
              var userName = _userNameController.value.text;
              var userPwd = _userPwdController.value.text;
              if (userName == 'zhaolei' && userPwd == '123') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MainPage(),
                ));
                Fluttertoast.showToast(
                    msg: '登录成功', backgroundColor: Colors.grey);
              } else {
                Fluttertoast.showToast(
                    msg: '账号或密码不正确', backgroundColor: Colors.grey);
              }
            },
            minWidth: 250,
            height: 50,
            child: Text(
              "登录",
              style: TextStyle(color: Colors.white),
            ),
            textTheme: ButtonTextTheme.normal,
            disabledTextColor: Colors.white,
            color: Colors.redAccent,
            splashColor: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(
                    color: Color(0xFFFFFFFF),
                    style: BorderStyle.solid,
                    width: 2)),
          ),
        ),
      ],
    );
  }
}
