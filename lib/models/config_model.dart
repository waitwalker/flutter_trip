/// 配置model
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