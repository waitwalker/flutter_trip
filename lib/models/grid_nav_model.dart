
import 'package:flutter_trip/models/common_model.dart';

/**
  *
  * @ClassName:      首页网格卡片model
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-06-28 11:32
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-06-28 11:32
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */
class GridNavModel {

  final GridItemModel hotel;
  final GridItemModel flight;
  final GridItemModel travel;
  GridNavModel({
    this.hotel,
    this.flight,
    this.travel,});//用大括号括起来说明这个字段时可选的

  factory GridNavModel.fromJson(Map<String, dynamic>json){
    return json != null ?
    GridNavModel(
      hotel: GridItemModel.fromJson(json["hotel"]),
      flight: GridItemModel.fromJson(json["flight"]),
      travel: GridItemModel.fromJson(json["travel"]),
    ) : null;
  }
}

class GridItemModel {

  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridItemModel({
    this.startColor,
    this.endColor,
    this.mainItem,
    this.item1,
    this.item2,
    this.item3,
    this.item4
  });//用大括号括起来说明这个字段时可选的

  factory GridItemModel.fromJson(Map<String, dynamic>json){
    return GridItemModel(
      startColor: json["startColor"],
      endColor: json["endColor"],
      mainItem: CommonModel.fromJson(json["mainItem"]),
      item1: CommonModel.fromJson(json["item1"]),
      item2: CommonModel.fromJson(json["item2"]),
      item3: CommonModel.fromJson(json["item3"]),
      item4: CommonModel.fromJson(json["item4"]),
    );
  }

}