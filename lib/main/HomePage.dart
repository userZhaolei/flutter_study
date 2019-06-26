import 'package:flutter/material.dart';
import 'package:flutter_study/http/ApiService.dart';
import 'package:flutter_study/main/NewsDetailPage.dart';
import 'package:flutter_study/model/home_banner.dart';
import 'package:flutter_study/model/home_chapter_list.dart';
import 'package:flutter_study/util/style_utils.dart';
import 'package:flutter_study/util/view_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<Data> _listBanner = [];
  List<Datas> _listChapter = [];
  int page = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _loadBannerData();
    _loadChapterData();
  }

  @override
  Widget build(BuildContext context) {
    if (_listChapter.length == 0 && _listBanner.length == 0) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
      ));
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("首页"),
            centerTitle: true,
            backgroundColor: Colors.red[600],
          ),
          body: new RefreshIndicator(
            color: Colors.red[600],
            child: new ListView.builder(
              itemCount: _listChapter.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
            ),
            onRefresh: _onRefresh,
          ));
    }
  }

  ///listview Item布局
  Widget _buildItem(int index) {
    if (index == 0) {
      return _creatBanner();
    } else if (index < _listChapter.length) {
      return _buildMainItem(index);
    } else {
      return ViewUtils.creatLoadMore();
    }
  }

  ///广告轮播
  Widget _creatBanner() {
    return Container(
      height: 150.0,
      padding: EdgeInsets.all(2.0),
      child: Swiper(
        //轮播组件 类似为viewPager
        autoplay: true,
        //开启
        pagination: SwiperPagination(
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
              color: Colors.white70, // 其他点的颜色
              activeColor: Colors.red[600], // 当前点的颜色
              space: 2, // 点与点之间的距离
            )),
        itemCount: _listBanner.length,
        onTap: (index) => _goToWebView(_listBanner[index].url),
        itemBuilder: (context, index) {
          return Image.network(
            _listBanner[index].imagePath,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  ///listview主布局
  _buildMainItem(int index) {
    var chapterData = _listChapter[index];
    return InkWell(
        onTap: () => _goToWebView(chapterData.link),
        child: Card(
          margin: EdgeInsets.all(6.0),
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(chapterData.title.replaceAll('&quot;', ''),
                    style: StyleUtils.TITLE_TEXT_STYLE),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 1.0),
                  child: Text(
                    '${(chapterData.superChapterName)}/${(chapterData.chapterName)}',
                    style: TextStyle(fontSize: 13.0, color: Colors.red[600]),
                  )),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 22.0,
                    ),
                    Text(chapterData.author, style: StyleUtils.SUB_TEXT_STYLE),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                              size: 22.0,
                            ),
                            Text(chapterData.niceDate,
                                style: StyleUtils.SUB_TEXT_STYLE)
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  ///刷新
  Future<void> _onRefresh() async {
    page = 1;
    ApiService.getHomeChapterListData(page).then((list) {
      setState(() {
        _listChapter = list.data.datas;
      });
    });
  }

  ///初始化listview监听
  void _initScrollListener() {
    //相当于底部滑动监听，当前位置到最大位置也就是最下面就加载下一页数据
    _scrollController.addListener(() {
      var p = _scrollController.position.pixels;
      var max = _scrollController.position.maxScrollExtent;
      if (p == max) {
        page++;
        _loadChapterData();
      }
    });
  }

  void _loadBannerData() {
    ApiService.getHomeBannerData().then((banner) {
      setState(() {
        _listBanner = banner.data;
      });
    });
  }

  void _loadChapterData() {
    ApiService.getHomeChapterListData(page).then((list) {
      setState(() {
        _listChapter.addAll(list.data.datas);
      });
    });
  }

  ///跳转web查看详情
  void _goToWebView(String url) {
    /*  Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewsDetailPage(id: url)));
*/
   // Navigator.of(context).pushNamed('/router/second');
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new NewsDetailPage(id: url);
    }));
  }
}
