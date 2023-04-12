import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourItem.dart';

import '../ApiCommand.dart/apiService.dart';
import '../Home/homePage.dart';
import '../Home/homeWidget.dart/ListWidget/BodyTempwidget.dart';
import '../Home/homeWidget.dart/ListWidget/Compass.dart';

class WeatherData {
  String _datasetDescription;
  List<Location> _locations;

  String get datasetDescription => _datasetDescription;
  List<Location> get locations => _locations;

  WeatherData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Location>.from(json['records']['location']
        .map((location) => Location.fromJson(location)));
  }
}

class Location {
  String _locationName;
  List<Weather> _weatherElements;

  String get locationName => _locationName;
  List<Weather> get weatherElements => _weatherElements;

  Location.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    _weatherElements = List<Weather>.from(
        json['weatherElement'].map((element) => Weather.fromJson(element)));
  }
}

class Weather {
  String _elementName;
  List<Time> _times;

  String get elementName => _elementName;
  List<Time> get times => _times;

  Weather.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Time>.from(json['time'].map((time) => Time.fromJson(time)));
  }
}

class Time {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterName;
  String _parameterValue;
  String _parameterUnit;

  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterName => _parameterName;
  String get parameterValue => _parameterValue;
  String get parameterUnit => _parameterUnit;

  Time.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterName = json['parameter']['parameterName'];
    _parameterValue = json['parameter']['parameterValue'];
    _parameterUnit = json['parameter']['parameterUnit'] ?? '';
  }
}

///////////////week data

class WeatherWeekData {
  String _datasetDescription;
  List<Locationweek> _locations;

  String get datasetDescription => _datasetDescription;
  List<Locationweek> get locations => _locations;

  WeatherWeekData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Locationweek>.from(json['records']['locations'][0]
            ['location']
        .map((location) => Locationweek.fromJson(location)));
  }
  @override
  String toString() {
    return 'WeatherWeekData(datasetDescription: $datasetDescription, locations: $locations)';
  }
}

class Locationweek {
  String _locationName;
  List<Weatherweek> _weatherElements;

  String get locationName => _locationName;
  List<Weatherweek> get weatherElements => _weatherElements;

  Locationweek.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    _weatherElements = List<Weatherweek>.from(
        json['weatherElement'].map((element) => Weatherweek.fromJson(element)));
  }
  @override
  String toString() {
    return 'Locationweek(locationName: $locationName, weatherElements: $weatherElements)';
  }
}

class Weatherweek {
  String _elementName;
  List<Timeweek> _times;

  String get elementName => _elementName;
  List<Timeweek> get times => _times;

  Weatherweek.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Timeweek>.from(
        json['time'].map((time) => Timeweek.fromJson(time)));
  }
  @override
  String toString() {
    return 'Weatherweek(elementName: $elementName, times: $times)';
  }
}

class Timeweek {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterValue;
  String _imageValue;
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterValue => _parameterValue;
  String get imageValue => _imageValue;
  Timeweek.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterValue = json['elementValue'][0]['value'];
    _imageValue = json['elementValue'][1]['value'];
  }
  @override
  String toString() {
    return 'Timeweek(startTime: $startTime, endTime: $endTime,parameterValue:$parameterValue,imageValue:$imageValue)';
  }
}

///////////////////////result week get
enum cloudType { T, Td, RH }

class CloudPage extends StatefulWidget {
  const CloudPage({this.title});
  final String title;
  @override
  _CloudPageState createState() => _CloudPageState();
}

final api = apiService();
// ignore: missing_return
Future<Map<String, dynamic>> getData(String country) async {
  final countrydata = await api.getCloudData(country);
  print(countrydata.toString());
  return countrydata;
}

// getSunRiseSetTime

Future<List<String>> getSunRiseSetData(String country) async {
  final countrydata = await api.getSunRiseSetTime(country);
  print(countrydata.toString());
  return countrydata;
}

class _CloudPageState extends State<CloudPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 74, 57, 131),
          title: Text(selectedOption)),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/homeBackground.png'),
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
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          textContent: '22° | 多雲時陰',
                          align: TextAlign.center,
                          fontSize: 20,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                          text: '紫外線UVI', view: uviData,
                          // icon: Icon(Icons.sunny),
                        ),
                        MyItem(
                          text: '日出及日落時間',
                          // icon: Icon(Icons.sunny_snowing),
                          // ignore: missing_return
                          view: FutureBuilder<List<String>>(
                            future: getSunRiseSetData(selectedOption),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final rise = snapshot.data[0];
                                final set = snapshot.data[1];
                                return Container(
                                    // width: screenWidth / 3,
                                    child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image(
                                              height: 70,
                                              width: screenWidth / 8,
                                              image: AssetImage(
                                                  'assets/sunrise.png')),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            textContent: rise,
                                            textColor: Colors.white,
                                            fontSize: 24,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // height: 30,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image(
                                              height: 70,
                                              width: screenWidth / 8,
                                              image: AssetImage(
                                                  'assets/sunset.png')),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CustomText(
                                            textContent: set,
                                            textColor: Colors.white,
                                            fontSize: 24,
                                          )
                                        ],
                                      ),
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
                            // icon: Icon(Icons.wind_power_outlined),
                            text: '風向$wdData',
                            view: CompassWidget(
                                size: screenHeight / 4,
                                direction: ParseCompassDirection.fromString(
                                    wdData ?? '偏北風'))),
                        MyItem(
                            text: '露點溫度',
                            view: RHTdwidget(
                              text: tdData + '℃',
                              value: tdData,
                              type: cloudType.Td,
                            )
                            //  一般都會在露點到達15℃至20℃時開始感到不適；而當露點越過21℃時更會感到悶熱。
                            ),
                      ],
                    ),
                    Row(
                      children: [
                        MyItem(
                            //  icon: Icon(Icons.temple_buddhist),
                            text: '體感溫度AT',
                            view: RHTdwidget(
                              text: tData + '℃',
                              value: tData,
                              type: cloudType.T,
                            )),
                        MyItem(
                            text: '濕度RH',
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
}

class MyItem extends StatelessWidget {
  final String text;
  final Icon icon;
  final Widget view;

  const MyItem({Key key, this.text, this.icon, this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Expanded(
      child: Container(
        width: screenHeight / 4,
        height: screenHeight / 4,
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
    );
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
        if (temp < 15) {
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
        if (temp < 30) {
          return '相對濕度過低，空氣比較乾燥，可能會引起喉嚨不適或皮膚乾燥。';
        } else if (temp >= 30 && temp <= 60) {
          return '相對濕度適中，感覺比較舒適。';
        } else {
          return '相對濕度過高，空氣比較悶熱，可能會引起暑熱不適或增加病毒等病害的傳播。';
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight =
    // MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Column(
      children: [
        SizedBox(
          width: 5,
        ),
        Container(
          width: screenWidth / 3 - 5,
          //  color: Colors.yellow,
          child: CustomText(
              textContent: text ?? '', fontSize: 40, align: TextAlign.left),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: CustomText(
              textContent: getrh(value, type) ?? ' ',
              fontSize: 15,
              align: TextAlign.left),
        )
      ],
    );
  }
}
