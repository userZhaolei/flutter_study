import 'package:flutter/material.dart';
import 'package:flutter_study/http/ApiService.dart';
import 'package:flutter_study/main/NewsDetailPage.dart';
import 'package:flutter_study/model/nav_model_entity.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NavigationState();
  }
}

class NavigationState extends State<NavigationPage> {
  List<NavModelData> navList = [];
  int isSelected = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (navList.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      );
    } else {
      return new MaterialApp(
        title: "导航",
        theme: new ThemeData(primaryColor: Colors.blueAccent),
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: navList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = index;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: isSelected == index
                                ? Color(0XFFFFFFFF)
                                : Color(0XFFF0F0F0),
                          ),
                          child: Text(
                            navList[index].name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                  flex: 2,
                  child: GridView.count(
                      crossAxisCount: 3,
                      // ignore: argument_type_not_assignable
                      children: navList[isSelected]
                          .articles
                          .map((NavModelDataArticle item) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewsDetailPage(
                                id: item.link,
                              );
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Color(0XFFF0F0F0)),
                            margin: EdgeInsets.all(5),
                            child: Text(item.title),
                            alignment: Alignment.center,
                          ),
                        );
                      }).toList())),
            ],
          ),
        ),
      );
    }
  }

  void _loadData() {
    ApiService.getNavData().then((model) {
      setState(() {
        navList = model.data;
      });
    });
  }
}
