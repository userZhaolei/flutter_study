import 'package:flutter/material.dart';
import 'package:flutter_study/http/ApiService.dart';
import 'package:flutter_study/main/NewsDetailPage.dart';
import 'package:flutter_study/model/tree_entity.dart';

class TreePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TreePageState();
  }
}

class TreePageState extends State<TreePage> {
  List<TreeData> treeList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (treeList.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      );
    } else {
      return new Scaffold(
        body: ListView.builder(
            itemCount: treeList.length,
            itemBuilder: (context, index) {
              return _items(treeList[index], treeList[index].children);
            }),
      );
    }
  }

  void _loadData() {
    ApiService.getTreeData().then((treeData) {
      setState(() {
        treeList = treeData.data;
      });
    });
  }

  Widget _items(TreeData treeList, List<TreeDatachild> treeDataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 18),
          child: Text(
            treeList.name,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          children: treeDataList.map((TreeDatachild item) {
            return Padding(
              padding: EdgeInsets.only(left: 15),
              child: Chip(
                label: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return NewsDetailPage(
                            id: item.name,
                          );
                        }));
                  },
                  child: Text(
                    item.name,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
                backgroundColor: _getColor(treeList.name),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  _getColor(String name) {
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 11)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }
}
