import 'package:flutter/material.dart';
import 'package:flutter_trip/models/common_model.dart';
import 'package:flutter_trip/models/sales_box_model.dart';
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

class Salesbox extends StatelessWidget {

  final SalesBoxModel salesBox;
  Salesbox({Key key,@required this.salesBox}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _items(context),
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
  }

  // 生成 Widgets
  _items(BuildContext context) {
    if (salesBox == null) {
      return null;
    }

    List<Widget> items = [];
    
    items.add(_doubleItem(context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(context, salesBox.smallCard3, salesBox.smallCard4, false, true));

    // 返回items
    return Column(
      children: <Widget>[
        Container(
          height: 44,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xfff2f2f2),width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                salesBox.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Color(0xffff4e63),Color(0xffff6cc9)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return WebView(url:salesBox.moreUrl,title: "更多活动",);
                    }));
                  },
                  child: Text(
                    "获取更多福利 >",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0,1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1,2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2,3),
        ),
      ],
    );

  }

  Widget _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard, bool isBig, bool isLast) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _item(context, leftCard, true, isLast, isBig),
        _item(context, rightCard, false, isLast, isBig),
      ],
    );
  }

  // 返回单个Widget
  Widget _item(BuildContext context, CommonModel model,bool isLeft, bool isLast, bool isBig) {
    BorderSide borderSide = BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            WebView(url: model.url,statusBarColor: model.statusBarColor,hideAppBar: model.hideAppBar,)
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: isLeft ? borderSide : BorderSide.none,
            bottom: isLast ? borderSide : BorderSide.none,
          ),
        ),
        child: Image.network(
          model.icon,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: isBig ? 129 : 80,
        ),
      )
    );
  }
}