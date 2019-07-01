import 'package:flutter/material.dart';
import 'package:flutter_trip/models/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

/**
 *
 * @ProjectName:    flutter_trip
 * @Package:        widget
 * @Company         etiantian
 * @Description:    类作用描述
 * @Author:         作者名:
 * @CreateDate:     2019-06-28 14:30
 * @UpdateUser:     更新者：
 * @UpdateDate:     2019-06-28 14:30
 * @UpdateRemark:   更新说明：
 * @Version:        1.0
 */

enum SearchBarType {
  home, normal, homeLight
} //首页,搜索页,首页高亮

class SearchBar extends StatefulWidget {

  final bool enabled;//是否禁止搜索
  final bool hideLeft;//左边按钮是否隐藏
  final SearchBarType searchBarType;
  final String hint;//默认提示文案
  final String defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;


  SearchBar({
    this.enabled = true,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged
});

  @override
  State<StatefulWidget> createState() {

    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {

  // 是否显示清空按钮
  bool showClear = false;

  // TextField的controller
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return widget.searchBarType == SearchBarType.normal ? _genNormalSearch() : _genHomeSearch();
  }

  _genNormalSearch() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
      child: Row(
        children: <Widget>[
          // 左边
          _wrapTap(
            Container(
              child: widget.hideLeft??false ? null : Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 26,
            ),
          ),
            widget.leftButtonClick
          ),

          // 输入框
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),

          // 右边搜索按钮
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  "搜索",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                  ),),
              ),
              widget.leftButtonClick
          ),
        ],
      ),
    );
  }

  _genHomeSearch() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
      child: Row(
        children: <Widget>[
          // 左边
          _wrapTap(
              Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      "上海",
                      style: TextStyle(
                          fontSize: 14,
                          color: _homeFontColor(),
                      ),
                    ),
                    Icon(
                      Icons.expand_more,
                      color: _homeFontColor(),
                      size: 22,
                    ),
                  ],
                ),
              ),
              widget.leftButtonClick
          ),

          // 输入框
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),

          // 右边搜索按钮
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(Icons.comment,color: _homeFontColor(),size: 26,)
              ),
              widget.leftButtonClick
          ),
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callBack) {
    return GestureDetector(
      onTap: (){
        if (callBack != null) callBack;
      },
      child: child,
    );
  }

  _inputBox() {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse("0xffEDEDED"));
    }

    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5: 15),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal ? Color(0xffA9A9A9) : Colors.blue,
          ),

          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal ? TextField(
              controller: _controller,
              onChanged: _onChanged,
              autofocus: true,//自动获取焦点
              style: TextStyle(fontSize: 18.0,color: Colors.black,fontWeight: FontWeight.w300),
              // 输入框样式
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                border: InputBorder.none,
                hintText: widget.hint ?? "",
                hintStyle: TextStyle(fontSize: 15),
              ),
            ) : _wrapTap(Container(
              child: Text(
                widget.defaultText,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey
                ),),
            ),
                widget.inputBoxClick
            ),
          ),

          !showClear ?
            _wrapTap(
              Icon(
                Icons.mic,
                size: 22,
                color: widget.searchBarType == SearchBarType.normal ? Colors.blue : Colors.grey,
              ),
                widget.speakClick
            ):GestureDetector(
            onTap: (){
              print("清空按钮被点击了");
              setState(() {
                _controller.clear();
              });
              _onChanged("");
            },
            child: Icon(
              Icons.clear,
              size: 22,
              color: Colors.grey,
            ),
          ),

        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.home
        ? Colors.white
        : Colors.black54;
  }

}