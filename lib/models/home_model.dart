import 'package:flutter_trip/models/common_model.dart';
import 'package:flutter_trip/models/config_model.dart';
import 'package:flutter_trip/models/grid_nav_model.dart';
import 'package:flutter_trip/models/sales_box_model.dart';

/**
 *
 * @ProjectName:    flutter_trip
 * @Package:        models
 * @Company         etiantian
 * @Description:    类作用描述
 * @Author:         作者名:
 * @CreateDate:     2019-06-26 14:32
 * @UpdateUser:     更新者：
 * @UpdateDate:     2019-06-26 14:32
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 */

class HomeModel {
  final ConfigModel config;//配置
  final List<CommonModel> bannerList;//banner
  final List<CommonModel> localNavList;//本地导航
  final List<CommonModel> subNavList;//卡片下面那个
  final GridNavModel gridNav;//卡片
  final SalesBoxModel salesBox;//活动

  HomeModel({
    this.config,
    this.bannerList,
    this.localNavList,
    this.gridNav,
    this.subNavList,
    this.salesBox
  });

  factory HomeModel.fromJson(Map<String,dynamic>json){
    var localNavListJson = json["localNavList"] as List;
    List<CommonModel> localNavList = localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json["bannerList"] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json["subNavList"] as List;
    List<CommonModel> subNavList = subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json["config"]),
      gridNav: GridNavModel.fromJson(json["gridNav"]),
      salesBox: SalesBoxModel.fromJson(json["salesBox"])
    );
  }


}