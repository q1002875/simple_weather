import 'dart:ui';

class SettingList {
  String title;
  List<String> body;
  List<Locale> locale;
  List<String> imageS;
  SettingList({this.title, this.body, this.locale, this.imageS});

  static List<SettingList> getDummyData() {
    return [
      SettingList(
          title: '設定語言',
          body: ['英文', '繁體中文'],
          locale: [Locale('en', 'US'), Locale('zh', 'Hant')]),
      SettingList(
          title: '設定背景',
          body: ['背景一', '背景二'],
          imageS: ['assets/homeBackground.png', 'assets/themeStar.png']),
    ];
  }
}
// Image(image: AssetImage('assets/themeStar.png'))