import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  String id;

  NewsDetailPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new NewsDateilState(url: id);
  }
}

class NewsDateilState extends State<NewsDetailPage> {
  String url;
  String detailDataStr;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  NewsDateilState({Key key, this.url});

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(Text(
      "页面详情",
      style: TextStyle(color: Colors.white),
    ));
    titleContent.add(Container(width: 50.0));

    return new WebviewScaffold(
      url: this.url,
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Row(
          //水平布局
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent, //字体详情
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      withZoom: false,
      withJavascript: true,
      withLocalStorage: true,
    );
  }
}
