import 'dart:async';
import 'dart:convert';//模型转换用到
import 'package:flutter_trip/models/travel_tab_model.dart';
import 'package:http/http.dart' as http;


class TravelTabDataManager {

  static Future<TravelTabModel> fetch() async {
    final http.Response response = await http.get("http://www.devio.org/io/flutter_app/json/travel_page.json");

    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception("旅拍类别接口请求失败");
    }
  }
}