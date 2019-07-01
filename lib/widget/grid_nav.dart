import 'package:flutter/material.dart';
import 'package:flutter_trip/models/common_model.dart';
import 'package:flutter_trip/models/grid_nav_model.dart';
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

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;
  GridNav({Key key,@required this.gridNavModel}):super(key:key);

  @override
  Widget build(BuildContext context) {

    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    // 酒店不为空
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }

    // 机票不为空
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }

    // 旅行不为空
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridItemModel gridItemModel, bool isFirst) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridItemModel.mainItem));
    items.add(_doubleItem(context, gridItemModel.item1, gridItemModel.item2));
    items.add(_doubleItem(context, gridItemModel.item3, gridItemModel.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(child: item,flex: 1,));
    });

    Color startColor = Color(int.parse("0xff" + gridItemModel.startColor));
    Color endColor = Color(int.parse("0xff" + gridItemModel.endColor));
    return Container(
      height: 88,
      margin: isFirst ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 线性渐变
        gradient: LinearGradient(colors: [startColor,endColor])
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel commonModel) {
    // 可点击的 用手势控件包裹
    return _wrapGesture(
        context,
        Stack( //实现绝对定位
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              commonModel.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,//局下显示
            ),
            Container(
              margin: const EdgeInsets.only(top: 11),
             child: Text(
               commonModel.title,
               style: TextStyle(
                   fontSize: 14,
                   color: Colors.white),
             ),
            ),
          ],
        ),
        commonModel);
  }

  _doubleItem(BuildContext context, CommonModel topItemModel, CommonModel bottomItemModel) {
    return Column(
      children: <Widget>[
        // 垂直方向上展开
        Expanded(child: _item(context, topItemModel, true)),
        Expanded(child: _item(context, bottomItemModel, false)),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      // 撑满父控件布局的宽度
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: borderSide,
            bottom: isFirst ? borderSide : BorderSide.none,
          )
        ),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget,CommonModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return WebView(
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppBar:model.hideAppBar,
            title: model.title,
          );
        }));
      },
      child: widget,
    );
  }
}