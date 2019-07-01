import 'package:flutter/material.dart';
import 'package:flutter_trip/data_manager/search_data_manager.dart';
import 'package:flutter_trip/models/search_model.dart';
import 'package:flutter_trip/widget/webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_trip/widget/search_bar.dart';

/**
  *
  * @ClassName:      搜索页面
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-06-26 15:02
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-06-26 15:02
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */

const kSearchUrl = "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contenType=json&keyword=";
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  SearchPage({this.hideLeft, this.searchUrl=kSearchUrl, this.keyword, this.hint});

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {

  String name = "四中";

  ScrollController _scrollController = ScrollController();
  String keyword;
  SearchModel searchModel;

  @override
  void initState() {
    super.initState();
     saveData();

     // 监听滚动
     _scrollController.addListener((){
       // 滚动到最大位置
       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
         // 加载更多数据
       }
     });
  }


  saveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", "etiantian");
  }

  readData () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final theName = preferences.getString("name").toString();
    setState(() {
      name = theName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          Expanded(
            flex: 1,
            child: MediaQuery.removeViewPadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  return _item(index);
                },
                itemCount: searchModel?.data?.length ?? 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onTextChange(text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    
    String url = widget.searchUrl + text;
    SearchDataManager.fetch(url,text).then((SearchModel model){
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e){
      print("搜索遇到错误:$e");
    });
  }

  _appBar() {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000),Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leftButtonClick: (){
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        )
      ],
    );
  }

  _item(int index) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[index];
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return WebView(url: item.url,title: "详情",);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3,color: Colors.grey)),
        ),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: Text("${item.word} ${item.districtname ?? ""} ${item.zonename ?? ""}"),
                ),
                Container(
                  width: 300,
                  child: Text("${item.price ?? ""} ${item.type ?? ""}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}