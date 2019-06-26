import 'package:flutter/material.dart';
import 'package:flutter_study/events/change_theme_color_event.dart';
import 'package:flutter_study/screen/ScreenPage.dart';
import 'package:flutter_study/util/EventBusUtils.dart';
import 'package:flutter_study/util/sp_util.dart';
import 'package:flutter_study/util/theme_util.dart';
import 'package:flutter_study/util/view_utils.dart';

class MyPage extends StatefulWidget {
  var parentContext;

  MyPage(this.parentContext);

  @override
  State<StatefulWidget> createState() {
    return PageState(parentContext);
  }
}

class PageState extends State<MyPage> {

  var context;
  PageState(this.context);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: _buildItem(),
        headerSliverBuilder: (context, isScrol) {
          return [ViewUtils.creatExpendAppBar()];
        });
  }


  _buildItem() {
    return ListView(
      children: <Widget>[
        new ExpansionTile(
          title: new Row(
            children: <Widget>[
              Icon(
                Icons.color_lens,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text('主题'),
              )
            ],
          ),
          children: <Widget>[
            Wrap(
              children: ThemeUtil.supportColors.keys.map((String key) {
                Color color = ThemeUtil.supportColors[key];
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    width: 36,
                    height: 36,
                    color: color,
                  ),
                  onTap: () {
                    SpUtil.setColorTheme(key);
                    EventBusUtils.eventBus
                        .fire(ChangeThemeColorEvent(color: color));
                  },
                );
              }).toList(),
            )
          ],
        ),
        new ListTile(
          title: Text("设置"),
          leading: Icon(Icons.sms),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        )
      ],
    );
  }
}
