import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:simple_weahter/Home/homePage.dart';
import 'package:simple_weahter/provider/provider_%20localization.dart';
import 'package:simple_weahter/provider/provider_theme.dart';

import 'Alert/AlertWeather.dart';
import 'Cloud/Cloud.dart';
import 'Setting/SettingPage.dart';

void main() {
  runApp(
    // 在根 widget 中使用 MultiProvider，同時提供 ThemeProvider 和 ThemeModel 類別
    MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Navigation Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "1"),
    // const MyModalPage(),
    CloudPage(title: ''),
    AlertPage(
      title: '',
    ),
    SettingPage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
   //  final localeProvider = Provider.of<LocaleProvider>(context);
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return 
    
  
    MaterialApp(
        supportedLocales: [
          Locale('en', 'US'),
          Locale('zh', 'Hant'),
        ],
        localizationsDelegates: [
          // delegate from flutter_localization
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // delegate from localization package.
          LocalJsonLocalization.delegate,
        ],
        locale: Locale('zh', 'Hant'),
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
          if (locale?.languageCode == 'zh') {
            return Locale('zh', 'Hant');
          }
            print('語言' + locale?.languageCode);
          return Locale('en', 'US');
        },
      home:   Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 62, 36, 105),
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.wb_sunny),
                color: _selectedIndex == 0 ? Colors.white : null,
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.cloud),
                color: _selectedIndex == 1 ? Colors.white : null,
                onPressed: () => _onItemTapped(1),
              ),
              IconButton(
                icon: Icon(Icons.warning),
                color: _selectedIndex == 2 ? Colors.white : null,
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                color: _selectedIndex == 3 ? Colors.white : null,
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    ));
    
    
    
   
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
