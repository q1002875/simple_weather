import 'package:flutter/cupertino.dart';





class LocaleProvider extends ChangeNotifier {
  // Locale _locale = Locale('zh', 'Hant');
  Locale _locale = Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
