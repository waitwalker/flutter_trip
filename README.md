**Flutter技术及其他交流群** 扫描👇二维码:


<img src="https://github.com/waitwalker/Resources/blob/master/Flutter/group/flutter_development.JPG?raw=true" width="350" height="500" align=center />


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Flutter是一个UI框架,其最重要的一块就是布局,就像官网所说的那样:"Flutter 布局的核心机制是 widgets。在 Flutter 中，几乎所有东西都是 widget —— 甚至布局模型都是 widgets。"采用何种布局方式视情况而定.

#### 项目结构
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;项目主要是根据贾鹏辉的一套教学视频跟着编写,项目现在放在[GitHub](https://github.com/waitwalker/flutter_trip)上,如果对你有帮助,请给一个星或者赞,谢谢!
主要结构:
```
.
├── common //包含主题和语言国际化等
│   ├── locale_mamager.dart
│   ├── localizations.dart
│   ├── localizations_delegate.dart
│   ├── string_base.dart
│   ├── string_en.dart
│   ├── string_zh.dart
│   └── theme_manager.dart
├── data_manager /// 数据管理层 负责数据的请求&组装等(Java中叫dao)
│   ├── home_data_manager.dart
│   ├── search_data_manager.dart
│   ├── travel_item_data_manager.dart
│   └── travel_tab_data_manager.dart
├── main.dart /// 入口
├── models /// model 层
│   ├── common_model.dart
│   ├── config_model.dart
│   ├── grid_nav_model.dart
│   ├── home_model.dart
│   ├── sales_box_model.dart
│   ├── search_model.dart
│   ├── travel_item_model.dart
│   └── travel_tab_model.dart
├── navigator /// 导航
│   └── tab_navigator.dart
├── pages /// 页面
│   ├── home_drawer.dart
│   ├── home_page.dart
│   ├── my_page.dart
│   ├── search_page.dart
│   ├── speak_page.dart
│   ├── travel_page.dart
│   └── travel_tab_page.dart
├── plugin /// 插件
│   └── asr_manager.dart
├── redux /// redux
│   ├── app_state.dart
│   ├── local_redux.dart
│   └── theme_data_reducer.dart
└── widget /// 组件
├── grid_nav.dart
├── loading_container.dart
├── local_nav.dart
├── sales_box.dart
├── search_bar.dart
├── sub_nav.dart
└── webview.dart
```

#### 主要模块
项目主要分为4个主要的模块:首页,搜索,旅拍,我的.
#### iOS
##### 首页
![home](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/iOS/home/home_join.jpg?raw=true)
##### 搜索
![search](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/iOS/search/search_join.png?raw=true)
##### 旅拍
![travel](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/iOS/travel/travel_join.jpg?raw=true)
##### 我的
![my](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/iOS/my/my_join.png?raw=true)

##### Android
##### 首页
![home](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/Android/home/home_join.jpg?raw=true)
##### 搜索
![search](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/Android/search/search_join.png?raw=true)
##### 旅拍
![travel](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/Android/travel/travel_join.jpg?raw=true)
##### 我的
![my](https://github.com/waitwalker/Resources/blob/master/Flutter/flutter_trip/Android/my/my_join.png?raw=true)

#### Redux
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;项目中通过Redux实现了主题的切换,Redux是响应式编程范畴,其在全局监听事件,然后驱动相关状态属性更新,主题切换主要在我的页面,把如下代码注释打开,并设置为Scaffold的body即可.
```
/// 主题切换
//  _container(Store<AppState> store) {
//    return Container(
//      color: store.state.themeData.primaryColor,
//      child: Center(
//          child: Column(
//            children: <Widget>[
//              Text("我的"),
//              RaisedButton(
//                child: Text("点击"),
//                onPressed: (){
//                  RandomColor _randomColor = RandomColor();
//                  ThemeData themeData = ThemeData(primaryColor: _randomColor.randomColor());
//                  store.dispatch(RefreshThemeDataAction(themeData));
//
//                  Locale locale = store.state.platformLocale;
//
//                  isClicked = !isClicked;
//                  if (isClicked) {
//                    locale = Locale("zh","CH");
//                  } else {
//                    locale = Locale("en","US");
//                  }
//                  store.dispatch(RefreshLocaleAction(locale));
//                },
//              ),
//            ],
//          )
//      ),
//    );
//  }
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;文章简要把项目结构展示了一下,以后有时间把其中用的布局,网络,缓存,数据处理,响应式等技术在详细说下.如果有需要可以先下载源码,详细参阅!

#### 博客地址&相关文章
**博客地址:** [https://waitwalker.cn/](https://waitwalker.cn/)


