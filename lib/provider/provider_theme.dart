
import 'package:flutter/material.dart';
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();
  Image _pimage =  Image(image: AssetImage('assets/homeBackground.png'));
  // Image simage =  Image(image: AssetImage('assets/themeStar.png'));

  Image get pimage => _pimage;

  ThemeData get themeData => _themeData;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  void setbackground(Image image) {

if (_pimage  != image) {
      _pimage = image;
      notifyListeners();
    }
  }
}


