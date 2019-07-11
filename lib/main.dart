import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_trip/common/localizations_delegate.dart';
import 'package:flutter_trip/navigator/tab_navigator.dart';
import 'package:flutter_trip/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'common/theme_manager.dart';



void main() => runApp(FlutterReduxApp());

class FlutterReduxApp extends StatelessWidget {

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
        themeData: ThemeManager.getThemeData(MTTColors.primarySwatch),
        locale: Locale("zh","CH")
    ),
  );

  @override
  Widget build(BuildContext context) {

    return StoreProvider(
        store: store,
        child: StoreBuilder<AppState>(builder: (context,store){
          //store.state.platformLocale = Localizations.localeOf(context);
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MTTLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            home: TabNavigator(),
          );
        }),
      );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}

