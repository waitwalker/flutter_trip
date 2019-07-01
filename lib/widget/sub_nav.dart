import 'package:flutter/material.dart';
import 'package:flutter_trip/models/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

/**
 *
 * @ProjectName:    flutter_trip
 * @Package:        widget
 * @Company         etiantian
 * @Description:    类作用描述
 * @Author:         作者名:
 * @CreateDate:     2019-06-28 14:30
 * @UpdateUser:     更新者：
 * @UpdateDate:     2019-06-28 14:30
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 */

class SubNav extends StatelessWidget {

  final List<CommonModel> subNavList;
  SubNav({Key key,@required this.subNavList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Padding(padding: EdgeInsets.all(7),
        child: _items(context),
      ),

    );
  }

  // 生成 Widgets
  _items(BuildContext context) {
    if (subNavList == null) {
      return null;
    }

    List<Widget> items = [];
    subNavList.forEach((model){
      items.add(_item(context, model));
    });

    // 每行显示数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    // 返回items
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,//平均排列
          children: items.sublist(0,separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,//平均排列
            children: items.sublist(separate,items.length),
          ),
        ),
      ],
    );

  }

  // 返回单个Widget
  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex:1,
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
            ));
          },
          child: Column(
            children: <Widget>[
              Image.network(
                model.icon,
                height: 18,
                width: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}