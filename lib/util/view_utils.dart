import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';

class ViewUtils {
  ///构建可变大缩小的appbar
  static Widget creatExpendAppBar() {
    return SliverAppBar(
//      title: Text('我的'),
      pinned: true,
      //固定在顶部
      floating: true,
      //随着滑动隐藏标题
      elevation: 10.0,
      expandedHeight: 130.0,
      //展开高度130
//      forceElevated: true,
      centerTitle: true,
      backgroundColor: Colors.red,
      //标题居中
      flexibleSpace: FlexibleSpaceBar(
          //缩小部分
          centerTitle: true,
          title: Icon(
            Icons.person_pin,
            size: 50,
            color: Colors.white,
          )),
    );
  }

  ///构建分割线
  static Divider creatDivider() {
    return Divider(height: 2.0, color: const Color.fromARGB(50, 183, 187, 197));
  }

  ///构建加载更多
  static Widget creatLoadMore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoActivityIndicator(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('加载更多中...',
              style: TextStyle(fontSize: 14.0, color: Colors.black54)),
        )
      ],
    );
  }
}
