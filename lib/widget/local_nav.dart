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

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;
  LocalNav({Key key,@required this.localNavList}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 64,
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
    if (localNavList == null) {
      return null;
    }

    List<Widget> items = [];
    localNavList.forEach((model){
      items.add(_item(context, model));
    });

    // 返回items
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,//平均排列
      children: items,
    );

  }

  // 返回单个Widget
  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            height: 32,
            width: 32,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}