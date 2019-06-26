import 'package:flutter/material.dart';
import 'package:flutter_study/main/LoginPage.dart';
import 'package:flutter_study/main/MainPage.dart';
import 'package:flutter_study/util/sp_util.dart';
import 'package:flutter_study/util/theme_util.dart';
import 'package:flutter_study/util/EventBusUtils.dart';
import 'package:flutter_study/events/change_theme_color_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Color themeColor;

  @override
  void initState() {
    super.initState();
    _initDefultTheme();
    _initThemeColorListener();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter学习",
      theme: ThemeData(primaryColor: themeColor),
      home: LoginPage(),
    );
  }

  _initDefultTheme() {
    SpUtil.getColorTheme().then((onValue) {
      setState(() {
        themeColor = ThemeUtil.supportColors[onValue];
      });
    });
  }

  _initThemeColorListener() {
    EventBusUtils.eventBus.on<ChangeThemeColorEvent>().listen((event) {
      setState(() {
        themeColor = ThemeUtil.supportColors[event];
      });
    });
  }
}
