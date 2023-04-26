import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';

import '../ApiCommand.dart/apiService.dart';
import '../ApiModel.dart/weathersModel2.dart';
import '../Home/homePage.dart';
import '../Home/homeWidget.dart/ListWidget/Compass.dart';
import '../provider/provider_theme.dart';
import 'TypeDetailWidget.dart';

final api = apiService();

// ignore: missing_return
Future<Map<String, dynamic>> getData(String country) async {
  final countrydata = await api.getCloudData(country);
  return countrydata;
}

// getSunRiseSetTime
Future<List<String>> getSunRiseSetData(String country) async {
  final countrydata = await api.getSunRiseSetTime(country);
  return countrydata;
}

// ignore: camel_case_types
enum cloudAllType {
  UVI,
  SUN,
  WD,
  T,
  Td,
  RH,
}

class CloudPage extends StatefulWidget {
  final String title;
  const CloudPage({this.title});
  @override
  _CloudPageState createState() => _CloudPageState();
}

///////////////////////result week get
enum cloudType { T, Td, RH }

class CustomPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  CustomPageRoute({
    this.builder,
    RouteSettings settings,
    bool fullscreenDialog = false,
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }
}

class MyItem extends StatelessWidget {
  final String text;
  final Icon icon;
  final Widget view;
  final cloudAllType types;
  const MyItem(
      {Key key, this.text, this.icon, this.view, this.types = cloudAllType.UVI})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(CustomPageRoute(
          builder: (_) => MyModalPage(type: types),
        ));
      },
      child: Container(
        width: screenHeight / 4,
        height: screenHeight / 3.5,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Color.fromARGB(120, 74, 57, 131),
        ),
        child: Column(
          children: [
            Container(
              // color: Colors.blueGrey,
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(textContent: text, textColor: Colors.white)
                ],
              ),
            ),
            Expanded(child: Container(width: screenWidth, child: view))
          ],
        ),
      ),
    ));
  }
}

// ignore: missing_return
class RHTdwidget extends StatelessWidget {
  final String text;
  final String Detaltext;
  final String value;
  final cloudType type;
  // ignore: non_constant_identifier_names
  const RHTdwidget({this.text, this.Detaltext, this.value, this.type});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight =
    // MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 5,
        ),
        Container(
          width: screenWidth / 3 - 5,
          child: CustomText(
              textContent: text ?? '', fontSize: 40, align: TextAlign.left),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            CustomText(
                textContent: getrh(value, type) ?? ' ',
                fontSize: 15,
                align: TextAlign.left),
          ],
        ))
      ],
    );
  }

  // ignore: missing_return
  String getrh(String value, cloudType type) {
    // 一般都會在露點到達15℃至20℃時開始感到不適；而當露點越過21℃時更會感到悶熱。
    final temp = int.parse(value);
    switch (type) {
      case cloudType.T:
        if (temp <= 25) {
          return '舒適溫度，感到涼爽舒適。';
        } else if (temp >= 26 && temp <= 29) {
          return '略微悶熱，需要注意保持適當的水分補充。';
        } else if (temp >= 30 && temp <= 34) {
          return '明顯的悶熱，出汗增加，需加強水分補充。';
        } else if (temp >= 35 && temp <= 39) {
          return '非常悶熱，易出現中暑等問題，需及時休息和補充水分。';
        } else if (temp >= 40) {
          return '極度炎熱，容易導致中暑，避免長時間暴露在高溫環境中。';
        } else {
          return '';
        }

        break;
      case cloudType.Td:
        if (temp <= 15) {
          return '相對濕度較低，感覺較為乾燥，不太容易出現露水現象。';
        } else if (temp >= 16 && temp <= 18) {
          return '相對濕度適中，感覺比較舒適，不易出現露水現象。';
        } else if (temp >= 19 && temp <= 22) {
          return '相對濕度較高，感覺比較悶熱，容易出現露水現象。';
        } else if (temp >= 23 && temp <= 25) {
          return '相對濕度高，感覺非常悶熱，容易出現露水現象。';
        } else if (temp >= 26) {
          return '相對濕度極高，感覺非常悶熱，露水現象明顯。';
        } else {
          return '';
        }

        break;
      case cloudType.RH:
        if (temp <= 30) {
          return '相對濕度過低，空氣比較乾燥，可能會引起喉嚨不適或皮膚乾燥。';
        } else if (temp >= 30 && temp <= 60) {
          return '相對濕度適中，感覺比較舒適。';
        } else {
          return '相對濕度過高，空氣比較悶熱，可能會引起暑熱不適或增加病毒等病害的傳播。';
        }
        break;
    }
  }
}

class _CloudPageState extends State<CloudPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 74, 57, 131),
          title: CustomText(
            textContent: selectedOption,
            textColor: Colors.white,
            fontSize: 20,
          )
          
          ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: context.read<ThemeProvider>().pimage.image,
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder<Map<String, dynamic>>(
            future: getData(selectedOption),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final uviData = snapshot.data['UVI'];
                final wdData = snapshot.data['WD'];
                final rhData = snapshot.data['RH'];
                final tdData = snapshot.data['Td'];
                final tData = snapshot.data['T'];
                final wind = cloudAllType.WD.name;
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('object');
                            Navigator.of(context).push(CustomPageRoute(
                              builder: (_) => MyModalPage(),
                            ));
                          },
                          child: FutureBuilder<WeatherData>(
                            future: getcountryData(selectedOption),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final weatherData = snapshot.data;
                                final weatherStatus = weatherData.locations[0]
                                    .weatherElements[0].times[0].parameterName;
                                final temperature = weatherData.locations[0]
                                    .weatherElements[2].times[0].parameterName;
                                return Container(
                                    child: CustomText(
                                  textContent:
                                      '$temperature° | ${weatherStatus.i18n()}',
                                  align: TextAlign.center,
                                  fontSize: 20,
                                  textColor: Colors.white,
                                ));
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                          text: cloudAllType.UVI.name,
                          view: uviData,
                          types: cloudAllType.UVI,
                        ),
                        MyItem(
                          types: cloudAllType.SUN,
                          text: cloudAllType.SUN.name,
                          view: FutureBuilder<List<String>>(
                            future: getSunRiseSetData(selectedOption),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final rise = snapshot.data[0];
                                final set = snapshot.data[1];
                                return Container(
                                    // width: screenWidth / 3,
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Image(
                                              height: screenWidth / 8,
                                              width: screenWidth / 8,
                                              image: AssetImage(
                                                  'assets/sunrise.png')),
                                        ),
                                        Flexible(
                                            flex: 2,
                                            child: CustomText(
                                              textContent: rise,
                                              textColor: Colors.white,
                                              fontSize: 21,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Image(
                                              height: screenWidth / 8,
                                              width: screenWidth / 8,
                                              image: AssetImage(
                                                  'assets/sunset.png')),
                                        ),
                                        Flexible(
                                            flex: 2,
                                            child: CustomText(
                                              textContent: set,
                                              textColor: Colors.white,
                                              fontSize: 22,
                                            ))
                                      ],
                                    ),
                                  ],
                                ));
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                            types: cloudAllType.WD,
                            text: wind,
                            view: CompassWidget(
                                size: screenHeight / 4,
                                direction: ParseCompassDirection.fromString(
                                    wdData ?? '偏北風'))),
                        MyItem(
                            types: cloudAllType.Td,
                            text: cloudAllType.Td.name,
                            view: RHTdwidget(
                              text: tdData + '°',
                              value: tdData,
                              type: cloudType.Td,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                            types: cloudAllType.T,
                            text: cloudAllType.T.name,
                            view: RHTdwidget(
                              text: tData + '°',
                              value: tData,
                              type: cloudType.T,
                            )),
                        MyItem(
                            types: cloudAllType.RH,
                            text: cloudAllType.RH.name,
                            view: RHTdwidget(
                              text: rhData + '%',
                              value: rhData,
                              type: cloudType.RH,
                            )),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  @override
  initState() {
    super.initState();
  }
}

extension cloudAllTypeExtension on cloudAllType {
  String get detailHeaderFirstTitle {
    switch (this) {
      case cloudAllType.UVI:
        return '紫外線指數';
        break;
      case cloudAllType.SUN:
        return '日出';
        break;
      case cloudAllType.WD:
        return '';
        break;
      case cloudAllType.T:
        return '攝氏度';
        break;
      case cloudAllType.Td:
        return '攝氏度';
        break;
      case cloudAllType.RH:
        return '百分比';
        break;
    }
  }

  String get detailHeaderSecondTitle {
    switch (this) {
      case cloudAllType.UVI:
        return '詳細內容';
        break;
      case cloudAllType.SUN:
        return '日落';
        break;
      case cloudAllType.WD:
        return '風向';
        break;
      case cloudAllType.T:
        return '詳細內容';
        break;
      case cloudAllType.Td:
        return '詳細內容';
        break;
      case cloudAllType.RH:
        return '詳細內容';
        break;
    }
  }

  String get Englishname {
    switch (this) {
      case cloudAllType.UVI:
        return 'UVI';
        break;
      case cloudAllType.SUN:
        return '日出日落';
        break;
      case cloudAllType.WD:
        return 'WD';
        break;
      case cloudAllType.T:
        return 'T';
        break;
      case cloudAllType.Td:
        return 'Td';
        break;
      case cloudAllType.RH:
        return 'RH';
        break;
    }
  }

  String get name {
    switch (this) {
      case cloudAllType.UVI:
        return '紫外線';
        break;
      case cloudAllType.SUN:
        return '日出日落';
        break;
      case cloudAllType.WD:
        return '風向';
        break;
      case cloudAllType.T:
        return '平均溫度';
        break;
      case cloudAllType.Td:
        return '露點溫度';
        break;
      case cloudAllType.RH:
        return '濕度';
        break;
    }
  }

  String get property {
    switch (this) {
      case cloudAllType.UVI:
        return '紫外線指數';
        break;
      case cloudAllType.SUN:
        return '攝氏度';
        break;
      case cloudAllType.WD:
        return '風向';
        break;
      case cloudAllType.T:
        return '攝氏度';
        break;
      case cloudAllType.Td:
        return '攝氏度';
        break;
      case cloudAllType.RH:
        return '%';
        break;
    }
  }
}
