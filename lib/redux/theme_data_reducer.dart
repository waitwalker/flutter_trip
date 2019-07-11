import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

/// 事件Reduc

/// 通过combineRecucers实现Reducer
final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData,RefreshThemeDataAction>(_refresh),
]);

/// 定义处理Action方法,返回新的State
ThemeData _refresh(ThemeData themeData, action){
  themeData = action.themeData;
  return themeData;
}

/// 定义Action,将Action在Reducer中与处理该Action的方法绑定
class RefreshThemeDataAction {
  final ThemeData themeData;
  RefreshThemeDataAction(this.themeData);
}