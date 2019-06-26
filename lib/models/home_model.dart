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
  final String title;
  final String imageUrl;
  HomeModel({this.title, this.imageUrl});

  factory HomeModel.fromJson(Map<String,dynamic> json){
    return HomeModel(
      title: json["title"],
      imageUrl: json["imageUrl"]
    );
  }

}