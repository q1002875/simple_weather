import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

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
    Locale _locale = Locale('en', 'US');
    return MaterialApp(
      locale: _locale,
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

      home: Container(
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.access_alarms_sharp),
              onPressed: () {
                setState(() {
                  // _locale = Locale('en', 'US');
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                setState(() {
                  // _locale = Locale('zh', 'Hant');
                });
              },
            ),
            Text('新竹縣'.i18n())
          ],
        ),
      ),

      // ...
    );

//    return Scaffold(
//         appBar: AppBar(
//             backgroundColor: Color.fromARGB(255, 74, 57, 131),
//             title: Text(text)),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/homeBackground.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     ElevatedButton(
//       onPressed: () {
//         // Handle button press

//       },
//       child: Text('Button 1'),
//     ),
//     SizedBox(height: 16),
//     ElevatedButton(
//       onPressed: () {
//         // Handle button press
//       },
//       child: Text('Button 2'),
//     ),
//   ],
// ),

//         ));
  }
}
