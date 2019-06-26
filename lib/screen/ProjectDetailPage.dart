import 'package:flutter/material.dart';
import 'package:flutter_study/http/ApiService.dart';
import 'package:flutter_study/main/NewsDetailPage.dart';
import 'package:flutter_study/model/project_content.dart';
import 'package:flutter_study/util/view_utils.dart';

class ProjectDetailPage extends StatefulWidget {
  int id = 0;

  ProjectDetailPage({@required this.id});

  @override
  State<StatefulWidget> createState() {
    return new ProjectDetailState();
  }
}

class ProjectDetailState extends State<ProjectDetailPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController;
  int curPage = 1;
  List<ContentDatas> _dataList = [];
  final TextStyle titleStyle = TextStyle(fontSize: 15.0, color: Colors.black);
  final TextStyle contentStyle = TextStyle(fontSize: 13.0, color: Colors.grey);
  final TextStyle subTextStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
  final grey = Colors.grey;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var curPos = _scrollController.position.pixels;
      var maxPos = _scrollController.position.maxScrollExtent;
      if (curPos == maxPos) {
        curPage++;
        getProjectData();
      }
    });
    getProjectData();
  }

  @override
  Widget build(BuildContext context) {
    if (_dataList.length == 0) {
      return Center(
          child: new CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red[600]),
      ));
    } else {
      return new ListView.builder(
        itemCount: _dataList.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index < _dataList.length - 1) {
            return Card(child: _buildItemWidget(index));
          } else {
            return ViewUtils.creatLoadMore();
          }
        },
      );
    }
  }

  //获取项目数据
  void getProjectData() {
    ApiService.getProjectContent(curPage, widget.id).then((list) {
      setState(() {
        _dataList.addAll(list.data.datas);
      });
    });
  }

  ///绘制item布局
  _buildItemWidget(int index) {
    ContentDatas data = _dataList[index];

    //左边left图片
    var leftPicView = Container(
      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          width: 90,
          height: 100,
          placeholder: 'images/image_default.png',
          image: data.envelopePic),
    );

    var rightTitle = Container(
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
      alignment: Alignment.bottomLeft,
      child: Text(
        data.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: titleStyle,
      ),
    );

    var content = Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        data.desc,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: contentStyle,
      ),
    );

    var bottomView = Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 20.0,
                color: grey,
              ),
              Text(
                data.author,
                style: subTextStyle,
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
          height: 20.0,
          width: 20.0,
          child: Icon(
            Icons.timer,
            size: 20.0,
            color: grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            data.niceDate,
            style: subTextStyle,
          ),
        ),
      ],
    );

    Widget item = Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(1.0),
          child: leftPicView,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[rightTitle, content, bottomView],
            ),
          ),
        )
      ],
    );

    return InkWell(
      child: item,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailPage(id: data.link)));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
