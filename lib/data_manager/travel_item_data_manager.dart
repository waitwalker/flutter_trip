import 'dart:async';
import 'dart:convert';//模型转换用到
import 'package:flutter_trip/models/travel_item_model.dart';
import 'package:http/http.dart' as http;


var Params = {
"districtId": -1,
"groupChannelCode": "tourphoto_global1",
"type": null,
"lat": -180,
"lon": -180,
"locatedDistrictId": 2,
"pagePara": {
"pageIndex": 1,
"pageSize": 10,
"sortType": 9,
"sortDirection": 0
},
"imageCutType": 1,
"head": {
"cid": "09031014111431397988",
"ctok": "",
"cver": "1.0",
"lang": "01",
"sid": "8888",
"syscode": "09",
"auth": null,
"extension": [
  {
    "name": "protocal",
    "value": "https"
  }
  ]
},
  "contentType": "json"
};

const String kURL = "http://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";

/// 旅拍页接口管理类
class TravelItemDataManager {

  static Future<TravelItemModel> fetch(String url, String groupChannelCode, int pageIndex, int pageSize) async {

    Map paramsMap = Params["pagePara"];
    Params["groupChannelCode"] = groupChannelCode;
    paramsMap["pageIndex"] = pageIndex;
    paramsMap["pageSize"] = pageSize;

    final http.Response response = await http.post(url,body: jsonEncode(Params));

    if (response.statusCode == 200) {
      print(response.bodyBytes);
      Utf8Decoder utf8decoder = Utf8Decoder();//修复中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      var rs = json.encode(result).toString();
      print(rs);
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception("旅拍页接口请求失败");
    }
  }
}