/**
 *
 * @ProjectName:    flutter_trip
 * @Package:        models
 * @Company         etiantian
 * @Description:    类作用描述
 * @Author:         作者名:
 * @CreateDate:     2019-06-28 11:14
 * @UpdateUser:     更新者：
 * @UpdateDate:     2019-06-28 11:14
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 */

class ConfigModel {
  final String searchUrl;
  ConfigModel({this.searchUrl});//用大括号括起来说明这个字段时可选的

  factory ConfigModel.fromJson(Map<String, dynamic>json){
    return ConfigModel(searchUrl: json["searchUrl"]);
  }

  Map<String, dynamic> toJson() {
    return {searchUrl:searchUrl};
  }
}