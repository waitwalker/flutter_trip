import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_trip/redux/app_state.dart';
import 'package:flutter_trip/redux/local_redux.dart';
import 'package:flutter_trip/redux/theme_data_reducer.dart';
import 'package:flutter_trip/widget/webview.dart';
import 'package:random_color/random_color.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyPageState();
  }
}

class _MyPageState extends State<MyPage> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store){
        return Scaffold(
          body:WebView(
            url: "https://m.ctrip.com/webapp/myctrip/",
            hideAppBar: true,
            backForbid: true,
            statusBarColor: "4c5bca",
          )
        );
      },
    );
  }

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
}