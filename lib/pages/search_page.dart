import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {

  String name = "四中";

  ScrollController _scrollController = ScrollController();

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
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(100),
            ),
            Container(
              child: Text(name,style: TextStyle(fontSize: 30),),
              height: 200,
              width: 100,
              color: Colors.red,
            ),
            RaisedButton(
              onPressed: (){
                readData();
              },
              child: Text("点击"),
            )
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