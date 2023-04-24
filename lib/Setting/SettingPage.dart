import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../provider/provider_ localization.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
 

  String text = 'welcome-text'.i18n();
  // prints 'This text is in english'
  @override
 Widget build(BuildContext context) {
  //  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: '新竹縣'.i18n(),
            locale: localeProvider.locale,
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
           
            home: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Text(
                    '${localeProvider.locale}',
                  ),
                  Text(
                    '${'welcome-text'.i18n()}',
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                        //  context.read<LocaleProvider>().setLocale(Locale('en', 'US'));
                    
                     setState(() {
                        localeProvider.setLocale(Locale('en', 'US'));
                     });
                      
                    },
                    child: Text('英文'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                     
                            //  context
                            // .read<LocaleProvider>()
                            // .setLocale(Locale('zh', 'Hant'));
                      
                   
                   setState(() {
                         localeProvider.setLocale(Locale('zh', 'Hant'));

                   });
                    },
                    child: Text('中文'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
