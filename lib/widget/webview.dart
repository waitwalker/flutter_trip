import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';


/**
 *
 * @ProjectName:    flutter_trip
 * @Package:        widget
 * @Company         etiantian
 * @Description:    类作用描述
 * @Author:         作者名:
 * @CreateDate:     2019-06-28 15:14
 * @UpdateUser:     更新者：
 * @UpdateDate:     2019-06-28 15:14
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 */


List<String> CATCH_URLS = ["https://m.ctrip.com/","https://m.ctrip.com/html5/","https://m.ctrip.com/html5"];

class WebView extends StatefulWidget {

  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;


  WebView({
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false
  });

  @override
  State<StatefulWidget> createState() {
    return _WebViewState();
  }
}

class _WebViewState extends State<WebView> {

  final FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webviewPlugin.close();

    _onUrlChanged = webviewPlugin.onUrlChanged.listen((String url){

    });
    _onStateChanged = webviewPlugin.onStateChanged.listen((WebViewStateChanged state){
      switch (state.type){
        case WebViewState.startLoad:
          print("webview 加载的url:${state.url}");
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webviewPlugin.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });

    _onHttpError = webviewPlugin.onHttpError.listen((WebViewHttpError error){
      print("webview error:$error");
    });
  }

  _isToMain (String url) {
    bool contain = false;
    if (CATCH_URLS.contains(url)) {
      contain = true;
    }
    return contain;
  }

  @override
  Widget build(BuildContext context) {

    String statusBarColorStr = widget.statusBarColor ?? "ffffff";
    Color backButtonColor;
    if (statusBarColorStr == "ffffff") {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse("0xff" + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,//是否缩放
              withLocalStorage: true,//是否缓存
              hidden: true,//是否隐藏
              initialChild: Container(  //webview 插件这里有个bug 即使在初始状态让它隐藏也没有隐藏 设置了加载圈也没用
                color: Colors.white,
                child: Center(
                  child: Text("Waiting..."),
                ),),
            ),),
        ],
      ),
    );
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    // 隐藏状态appbar
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(//让Widget充满屏幕宽度
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(
                    color: backButtonColor,
                    fontSize: 20
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewPlugin.dispose();
    super.dispose();
  }
}