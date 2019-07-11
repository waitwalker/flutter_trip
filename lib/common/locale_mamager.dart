import 'package:flutter/material.dart';
import 'package:flutter_trip/common/localizations.dart';
import 'package:flutter_trip/common/string_base.dart';


class LocaleManager {
  static MTTStringBase getLocale(BuildContext context) {
    return MTTLocalizations.of(context).currentLocalized;
  }
}