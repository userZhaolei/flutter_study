import 'package:flutter_study/http/HttpUtil.dart';
import 'package:flutter_study/model/home_banner.dart';
import 'package:flutter_study/model/home_chapter_list.dart';
import 'package:flutter_study/model/nav_model_entity.dart';
import 'package:flutter_study/model/project_bean.dart';
import 'package:flutter_study/model/project_content.dart';
import 'package:flutter_study/model/tree_entity.dart';

class ApiService {
  static const TAG = "ApiService====";

  //首页banner https://www/wanandroid.com/banner/json
  static const HOME_BANNER = 'banner/json';

  //首页文章 https://www.wanandroid.com/article/list/0/json
  static const HOME_CHAPTER_LIST = 'article/list/';

  //项目分类 分类  'https://www.wanandroid.com/project/tree/json'
  static const PROJECT_CATEGORY = 'project/tree/json';

  //导航
  static const NAVI_URL = 'navi/json';

  //条目
  static const TREE_URL = 'tree/json';

  ///获取首页banner
  static Future<HomeBanner> getHomeBannerData() async {
    try {
      var response = await HttpUtil().get(HOME_BANNER);
      var homeBanner = HomeBanner.fromJson(response.data);
//      print('错误码code--------${homeBanner.errorCode}${homeBanner.errorMsg}');
      return HomeBanner.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取首页文章列表 [page]页数
  static Future<HomeChapterList> getHomeChapterListData(int page) async {
    try {
      var response = await HttpUtil().get('$HOME_CHAPTER_LIST$page/json');
      return HomeChapterList.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取项目分类
  static Future<ProjectBean> getProjectCategory() async {
    try {
      var response = await HttpUtil().get(PROJECT_CATEGORY);
      return ProjectBean.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取项目分类下的列表
  static Future<ProjectContent> getProjectContent(int page, int id) async {
    try {
      var response = await HttpUtil().get('project/list/$page/json?cid=$id');
      return ProjectContent.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///获取导航下数据
  static Future<NavModelEntity> getNavData() async {
    try {
      var response = await HttpUtil().get(NAVI_URL);
      return NavModelEntity.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }

  ///条目体系
  static Future<TreeEntity> getTreeData() async {
    try {
      var response = await HttpUtil().get(TREE_URL);
      return TreeEntity.fromJson(response.data);
    } catch (e, s) {
      print('TAG$s');
      return null;
    }
  }
}
