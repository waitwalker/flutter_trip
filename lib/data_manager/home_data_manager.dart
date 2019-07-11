import 'dart:async';
import 'dart:convert';//模型转换用到
import 'package:flutter_trip/models/home_model.dart';
import 'package:http/http.dart' as http;


const kHomeUrl = "http://www.devio.org/io/flutter_app/json/home_page.json";

/// 首页数据管理
class HomeDataManager {

  static Future<HomeModel> fetch() async {
    final http.Response response = await http.get(kHomeUrl);

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception("首页接口请求失败");
    }
  }
}