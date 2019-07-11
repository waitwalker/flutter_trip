
/// Common model
class CommonModel {

  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;
  CommonModel({this.icon,this.title,this.url,this.statusBarColor,this.hideAppBar});//用大括号括起来说明这个字段时可选的

  factory CommonModel.fromJson(Map<String, dynamic>json){
    return CommonModel(
        icon: json["icon"],
        title: json["title"],
        url: json["url"],
        statusBarColor: json["statusBarColor"],
        hideAppBar: json["hideAppBar"]);
  }
}