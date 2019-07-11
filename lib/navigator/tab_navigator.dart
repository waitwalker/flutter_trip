import 'package:flutter/material.dart';
import 'package:flutter_trip/common/locale_mamager.dart';
import 'package:flutter_trip/pages/home_drawer.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_trip/redux/app_state.dart';





// 底部页面+导航
class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {

  // 默认颜色 未选中
  final Color _defalutColor = Colors.grey;

  // 选中状态下颜色
  final Color _activeColor = Colors.blue;

  // 当前索引 选中 控制选中哪个页面
  int _currentIndex = 0;

  // 管理pageView
  final PageController _contraoller = PageController(
    initialPage: 0,//初始页面
  );

  @override
  Widget build(BuildContext context) {

    return StoreBuilder<AppState>(
      builder: (context,store){
        return Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),//关闭整个页面的联动
            controller: _contraoller,
            // children显示得是页面 四个主页面
            children: <Widget>[
              HomePage(),
              SearchPage(hideLeft: true,),
              TravelPage(),
              MyPage(),
            ],
          ),
          drawer: HomeDrawer(),

          // 底部导航
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: store.state.themeData.primaryColor,
              currentIndex: _currentIndex, //当前索引 第几页
              onTap: (index){ //切换当前索引
                setState(() {
                  _contraoller.jumpToPage(index);//跳转到相印页面
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,//将item固定
              items: [
                // 首页item
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,color: _defalutColor,), //未选中
                    activeIcon:Icon(Icons.home,color: _activeColor,),//选中
                    title: Text(LocaleManager.getLocale(context).tab_item_home,style: TextStyle(
                      color: _currentIndex != 0 ? _defalutColor : _activeColor,
                    ),)
                ),

                // 搜索item
                BottomNavigationBarItem(
                    icon: Icon(Icons.search,color: _defalutColor,), //未选中
                    activeIcon:Icon(Icons.search,color: _activeColor,),//选中
                    title: Text("搜索",style: TextStyle(
                      color: _currentIndex != 1 ? _defalutColor : _activeColor,
                    ),)
                ),

                // 旅拍item
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt,color: _defalutColor,), //未选中
                    activeIcon:Icon(Icons.camera_alt,color: _activeColor,),//选中
                    title: Text("旅拍",style: TextStyle(
                      color: _currentIndex != 2 ? _defalutColor : _activeColor,
                    ),)
                ),

                // 我的item
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle,color: _defalutColor,), //未选中
                    activeIcon:Icon(Icons.account_circle,color: _activeColor,),//选中
                    title: Text("我的",style: TextStyle(
                      color: _currentIndex != 3 ? _defalutColor : _activeColor,
                    ),)
                ),
              ]

          ),
        );
      },
    );
  }
}