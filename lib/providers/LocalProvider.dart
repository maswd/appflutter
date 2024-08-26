import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('fa');

  Locale get locale => _locale;

  void toggleLocale() {
    if (_locale.languageCode == 'fa') {
      _locale = const Locale('en');
    } else {
      _locale = const Locale('fa');
    }
    notifyListeners();
  }
}
