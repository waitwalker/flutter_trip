import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/data_manager/home_data_manager.dart';
import 'package:flutter_trip/models/common_model.dart';
import 'package:flutter_trip/models/grid_nav_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/models/home_model.dart';
import 'package:flutter_trip/widget/local_nav.dart';


// 定义一个常量
const kAppBar_Scroll_Offset = 100;

/**
  *
  * @ClassName:      首页
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-06-26 11:17
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-06-26 11:17
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  // 图片地址
  List<String> _imageUlrs = [
    "https://dimg04.c-ctrip.com/images/a10915000000xdmfo60F6.jpg",
    "https://dimg04.c-ctrip.com/images/a10i15000000xptxoA856.jpg",
    "https://dimg02.c-ctrip.com/images/a10s0u000000jbef9A566.jpg",
  ];

  // 顶部导航默认值
  double appBarAlpha = 0;

  String resultString = "";

  // 首页数据模型
  HomeModel homeModel;
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;

  /**
   * @method  监听滚动范围
   * @description 描述一下方法的作用
   * @date: 2019-06-26 13:31
   * @author: 作者名
   * @param offset 滚动范围
   * @return null
   */
  _onScroll(offset) {
    print(offset);
    double alpha = offset / kAppBar_Scroll_Offset;

    // 判断滚动范围
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });

    print("首页appbar 滚动透明度:$appBarAlpha");
  }

  /**
   * @method  获取首页数据
   * @description 描述一下方法的作用
   * @date: 2019-06-28 13:52
   * @author: 作者名
   * @param
   * @return
   */
  loadData() async {
    // 一种方式
    try {
      HomeModel homeM = await HomeDataManager.fetch();
      setState(() {
        localNavList = homeM.localNavList;
        gridNavModel = homeM.gridNav;
      });
    } catch (e) {
      setState(() {
        resultString = e.toString();
      });
    }

    // 另一种方式
//    HomeDataManager.fetch().then((result){
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e){
//      setState(() {
//        resultString = e.toString();
//      });
//    });
  }


  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//移出顶部状态安全区域
      backgroundColor: Color(0xfff2f2f2),
      body: Stack( //层叠布局 将自定义得appBar放在 列表上面
        children: <Widget>[
          // 移除ListView距离屏幕顶部得边距
          MediaQuery.removePadding(
            removeTop: true,//移出哪边得安全区域
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification){ //监听滚动
                // 滚动变化 才监听 && 第0个元素发生滚动得时候才监听
                if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  // Banner
                  Container(
                    height: 180,
                    child: Swiper( //轮播图
                      itemCount: homeModel != null ? homeModel.bannerList.length : _imageUlrs.length,
                      autoplay: true,//自动播放
                      itemBuilder: (BuildContext context, int index) { //显示得Widget
                        return Image.network(
                          homeModel != null ? homeModel.bannerList[index].icon : _imageUlrs[index],
                          fit: BoxFit.fill,//图片适配方式
                        );
                      },
                      pagination: SwiperPagination(),//当前页指示器
                    ),
                  ),

                  // 球区入口
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
                    child: LocalNav(localNavList: localNavList),
                  ),

                  // 中间卡片
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: GridNav(gridNavModel: gridNavModel),
                  ),

                  Container(
                    child: Text(resultString),
                    height: 1000,
                  ),
                ],
              ),
            ),
          ),

          // appBar
          Opacity(
            opacity: appBarAlpha,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),//装饰器
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("首页"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
