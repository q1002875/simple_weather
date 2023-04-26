import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Setting/setting_expend_detail.dart';
import 'package:simple_weahter/Setting/setting_list.dart';

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
  final showSettingList = SettingList.getDummyData();
  int _currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    //  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
    // final theme = context.read<ThemeProvider>().themeData;
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
      home: Container(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 74, 57, 131),
                title: CustomText(
                  textContent: "設定",
                  textColor: Colors.white,
                  fontSize: 20,
                )),
            body: Container(
                height: screenHeight,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: context.read<ThemeProvider>().pimage.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  
                  child: Container(
                    //  color: Colors.blue,
                    child: ExpansionPanelList(
                     
                      animationDuration: Duration(milliseconds: 500),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _currentIndex = isExpanded ? -1 : index;
                        });
                      },
                      children: showSettingList
                          .map<ExpansionPanel>((SettingList item) {
                        final section = showSettingList.indexOf(item);
                        return ExpansionPanel(
                          backgroundColor:  Color.fromARGB(255, 74, 57, 131),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return Container(
                                color: const Color.fromARGB(255, 74, 57, 131),
                                child: Container(
                                    // margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 18, 54, 96),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: CustomText(
                                      textContent: item.title,
                                    )));
                          },
                          body: Container(
                            alignment: Alignment.center,
                            color: Color.fromARGB(255, 18, 54, 96),
                            width: double.infinity,
                            height: screenHeight/6,
                            child: ListView.builder(
                              
                              scrollDirection: Axis.vertical,
                              itemCount: item.body.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      switch (section) {
                                        case 0:
                                          context
                                              .read<LocaleProvider>()
                                              .setLocale(item.locale[index]);
                                          setState(() {});
                                          break;
                                        case 1:
                                          context
                                              .read<ThemeProvider>()
                                              .setbackground(Image(
                                                  image: AssetImage(
                                                      item.imageS[index])));
                                          setState(() {});
                                          break;
                                      }
                                    },
                                    child: setting_expend_detail(
                                      data: item,
                                      section: section,
                                      index: index,
                                      screenheight: screenHeight/6,
                                    )
                                    );
                              },
                            ),
                          ),
                          isExpanded:
                              _currentIndex == showSettingList.indexOf(item),
                        );
                      }).toList(),
                    ),
                  ),
                ))),
      ),
    );
  }
}
