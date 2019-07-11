import 'package:flutter/material.dart';
import 'package:flutter_trip/data_manager/travel_tab_data_manager.dart';
import 'package:flutter_trip/models/travel_item_model.dart';
import 'package:flutter_trip/models/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_page.dart';
const String kURL = "http://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5";
class TravelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TravelPageState();
  }
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  
  TabController _tabController;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;
  
  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    TravelTabDataManager.fetch().then((TravelTabModel model){
      _tabController = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e){
      print("获取旅拍tab失败$e");
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
              labelColor: Colors.black,
              labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
              isScrollable: true,
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3,color: Colors.blue),
                insets: EdgeInsets.only(bottom: 10)
              ),
              tabs: tabs.map<Tab>((TravelTab tab){
                return Tab(text: tab.labelName,);
              }).toList()
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: tabs.map((TravelTab tab){
                return TravelTabPage(travelUrl: travelTabModel.url,groupChannelCode: tab.groupChannelCode,);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}