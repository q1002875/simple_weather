import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../provider/provider_ localization.dart';
import '../provider/provider_theme.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String text = 'welcome-text'.i18n();
  // prints 'This text is in english'
  @override
  Widget build(BuildContext context) {
    //  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    final theme = context.read<ThemeProvider>().themeData;
    return MaterialApp(
        title: '新竹縣'.i18n(),
        locale: context.read<LocaleProvider>().locale,
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('zh', 'Hant'),
        ],
        localizationsDelegates: [
          LocalJsonLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme:theme,
        home: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
            image: context.read<ThemeProvider>().pimage.image,
            fit: BoxFit.cover,
          ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${context.read<LocaleProvider>().locale}',
              ),
              Text(
                '${'welcome-text'.i18n()}',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // localeProvider.setLocale(Locale('en', 'US'));
                    context
                        .read<LocaleProvider>()
                        .setLocale(Locale('en', 'US'));
                          context.read<ThemeProvider>().setbackground(
                      Image(image: AssetImage('assets/homeBackground.png')));
                  });
                },
                child: Text('英文'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // localeProvider.setLocale(Locale('zh', 'Hant'));
                    context
                        .read<LocaleProvider>()
                        .setLocale(Locale('zh', 'Hant'));

                    context
                        .read<ThemeProvider>().setbackground(Image(image: AssetImage('assets/themeStar.png')));

                  });
                },
                child: Text('中文'),
              ),
            ],
          ),
        ),
      );
   

    // ChangeNotifierProvider(
    //   create: (_) => LocaleProvider(),
    //   child: Consumer<LocaleProvider>(
    //     builder: (context, localeProvider, child) {
    //       return MaterialApp(
    //         title: '新竹縣'.i18n(),
    //         locale: localeProvider.locale,
    //         supportedLocales: [
    //           const Locale('en', 'US'),
    //           const Locale('zh', 'Hant'),
    //         ],
    //         localizationsDelegates: [
    //           LocalJsonLocalization.delegate,
    //           GlobalMaterialLocalizations.delegate,
    //           GlobalWidgetsLocalizations.delegate,
    //           GlobalCupertinoLocalizations.delegate,
    //         ],
    //         home: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Text(
    //                 '${localeProvider.locale}',
    //               ),
    //               Text(
    //                 '${'welcome-text'.i18n()}',
    //               ),
    //               SizedBox(height: 20),
    //               ElevatedButton(
    //                 onPressed: () {
    //                   //  context.read<LocaleProvider>().setLocale(Locale('en', 'US'));

    //                   setState(() {
    //                     localeProvider.setLocale(Locale('en', 'US'));
    //                   });
    //                 },
    //                 child: Text('英文'),
    //               ),
    //               ElevatedButton(
    //                 onPressed: () {
    //                   //  context
    //                   // .read<LocaleProvider>()
    //                   // .setLocale(Locale('zh', 'Hant'));

    //                   setState(() {
    //                     localeProvider.setLocale(Locale('zh', 'Hant'));
    //                   });
    //                 },
    //                 child: Text('中文'),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
