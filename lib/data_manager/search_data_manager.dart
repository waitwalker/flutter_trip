import 'dart:async';
import 'dart:convert';//模型转换用到
import 'package:flutter_trip/models/search_model.dart';
import 'package:http/http.dart' as http;


const kSearchUrl = "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contenType=json&keyword=";

/// 搜索页面数据管理类
class SearchDataManager {

  static Future<SearchModel> fetch(String url, String text) async {
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      // 防止搜索过快
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception("搜索接口请求失败");
    }
  }
}