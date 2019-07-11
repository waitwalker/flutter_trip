import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_trip/common/string_base.dart';
import 'package:flutter_trip/common/string_en.dart';

///自定义多语言实现
class MTTLocalizations {
  final Locale locale;

  MTTLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///GSYStringEn和GSYStringZh都继承了GSYStringBase
  static Map<String, MTTStringBase> _localizedValues = {
    'en': new MTTStringEn(),
    'zh': new MTTStringEn(),
  };

  MTTStringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 GSYLocalizations
  ///获取对应的 GSYStringBase
  static MTTLocalizations of(BuildContext context) {
    return Localizations.of(context, MTTLocalizations);
  }
}