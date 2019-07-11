import 'package:flutter/material.dart';
import 'package:flutter_trip/redux/local_redux.dart';
import 'package:flutter_trip/redux/theme_data_reducer.dart';


/**
  *
  * @ClassName:      AppState类
  * @Description:    类作用描述
  * @Author:         作者名：liuchuanan
  * @CreateDate:     2019-07-05 09:46
  * @UpdateUser:     更新者：
  * @UpdateDate:     2019-07-05 09:46
  * @UpdateRemark:   更新说明：
  * @Version:        1.0
 */
class AppState {
  ThemeData themeData;
  Locale locale;
  Locale platformLocale;
  AppState({this.themeData,this.locale});
}

/**
 * @method  创建Reducer
 * @description 描述一下方法的作用
 * @date: 2019-07-05 09:47
 * @author: 作者名
 * @param
 * @return
 */
AppState appReducer(AppState state, action) {
  return AppState(
    themeData: ThemeDataReducer(state.themeData,action),
    locale: LocaleReducer(state.locale,action),
  );
}

