import 'package:flutter/material.dart';
import 'package:flutter_study/http/ApiService.dart';
import 'package:flutter_study/model/project_bean.dart';
import 'package:flutter_study/screen/ProjectDetailPage.dart';

class ScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ScreenState();
  }
}

class ScreenState extends State<ScreenPage> {
  List<ProjectData> _dataList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_dataList.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[600]),
        ),
      );
    } else {
      return DefaultTabController(
        length: _dataList.length,
        child: new Scaffold(
          appBar: AppBar(
            title: Text('筛选'),
            centerTitle: true,
            backgroundColor: Colors.redAccent,
            bottom: TabBar(
              tabs: _buildTabs(),
              indicatorColor: Colors.red,
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: _buildTabBarView(),
          ),
        ),
      );
    }
  }

  ///获取tabs
  List<Tab> _buildTabs() {
    List<Tab> _tabList = [];
    for (var value in _dataList) {
      _tabList.add(Tab(
        text: value.name.replaceAll('&amp;', ''),
      ));
    }
    return _tabList;
  }

  void getData() {
    ApiService.getProjectCategory().then((list) {
      setState(() {
        _dataList = list.data;
      });
    });
  }

  ///获取tabview
  _buildTabBarView() {
    List<Widget> tabBarView = [];
    for (var value in _dataList) {
      tabBarView.add(ProjectDetailPage(
        id: value.id,
      ));
    }
    return tabBarView;
  }
}
