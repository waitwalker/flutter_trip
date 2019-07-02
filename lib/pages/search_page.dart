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

const kTypes = [
  "channelgroup",
  "gs",
  "plane",
  "train",
  "cruise",
  "district",
  "food",
  "hotel",
  "huodong",
  "shop",
  "sight",
  "ticket",
  "travelgroup"
];

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
            Container(
              margin: EdgeInsets.all(1),
              child: Image(image: AssetImage(_typeImage(item.type)),width: 26,height: 26,),
              
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child: _subTitle(item),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _typeImage(String type) {
    if (type == null) {
      return "images/type_travelgroup.png";
    }

    String path = "travelgroup";

    for (final val in kTypes) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return "images/type_$path.png";
  }

  _title(SearchItem item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word,searchModel.keyword));
    spans.add(TextSpan(
        text: " " + (item.districtname??"") + " " + (item.zonename??""),
        style: TextStyle(color: Colors.grey,fontSize: 16)));
    return RichText(text: TextSpan(children: spans));
  }

  _subTitle(SearchItem item) {
    if (item == null) {
      return null;
    }
    return RichText(text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: item.price??"",
          style: TextStyle(fontSize: 16,color: Colors.orange)
        ),
        TextSpan(
            text: " " + (item.price??""),
            style: TextStyle(fontSize: 12,color: Colors.grey)
        ),
      ]
    ));
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan>spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16,color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16,color: Colors.orange);

    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword,style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val,style: normalStyle));
      }
    }
    return spans;
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}