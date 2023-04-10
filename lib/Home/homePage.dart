import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import '../ApiModel.dart/weathersModel.dart';
import '../ExtensionToolClass/CustomText.dart';
import '../ExtensionToolClass/ReusableFutureBuilder.dart';
import '../ExtensionToolClass/StorageService.dart';
import 'homeWidget.dart/ListWidget/weatherHourItem.dart';
import 'homeWidget.dart/countryWeatherHourType.dart';
import 'homeWidget.dart/countryWeatherState.dart';

enum WeaterStatusType {
  Wx, //天氣狀態
  MaxT //最低溫
}

class HomePage extends StatefulWidget {
  const HomePage({this.title});
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

final api = apiService();
// ignore: missing_return
Future<WeatherData> getcountryData(String country) async {
  final countrydata = await api.getCountryData(country);
  return countrydata;
}

Future<WeatherWeekData> getWeekCountryData(String country) async {
  final data = await api.getWeekCountryData(country);
  return data;
}

Future<Weathers> getWeekData(String country) async {
  final data = await api.getWeekData(country);
  final resultdata = data.toString();
  print('resultdata$resultdata');
  return data;
}

// ignore: missing_return

class _HomePageState extends State<HomePage> {
  StorageService _storageService = StorageService();

  Future<void> _onRefresh() async {
    // setState() {
    //   print('reflash');
    // }
  }

  List<String> options = [
    '臺北市',
    '新北市',
    '桃園市',
    '臺中市',
    '臺南市',
    '高雄市',
    '基隆市',
    '新竹縣',
    '新竹市',
    '苗栗縣',
    '彰化縣',
    '南投縣',
    '雲林縣',
    '嘉義縣',
    '嘉義市',
    '屏東縣',
    '宜蘭縣',
    '花蓮縣',
    '臺東縣',
    '澎湖縣',
    '金門縣',
    '連江縣',
  ];
  String selectedOption = '新竹縣'; //預設
  @override
  initState() {
    super.initState();
    initializeDateFormatting('zh_Hant');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final List<Widget> push = [ImageTextWidget(text: 'time')];

    return MaterialApp(
      title: 'Flutter Pull-to-Refresh',
      home: Scaffold(
          body: Container(
              child: FutureBuilder<String>(
                  future: _storageService.loadData('country'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      setState(() {
                        // selectedOption = snapshot.data;
                      });
                    }
                    return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/homeBackground.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ListView(
                              children: [
                                Container(
                                    child: Center(
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.black26,
                                    value: selectedOption,
                                    items: options.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: CustomText(
                                            textContent: option, fontSize: 24),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        selectedOption = newValue;
                                        _storageService.saveData(
                                            'country', newValue);
                                      });
                                    },
                                  ),
                                )),
                                Container(
                                    width: screenWidth / 1.6,
                                    height: screenHeight / 2.2,
                                    // color: Colors.purple,
                                    child: FutureBuilder<WeatherData>(
                                      future: getcountryData(selectedOption),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final weatherData = snapshot.data;
                                          return Container(
                                            child: CountryWeather(
                                                height: screenHeight / 2.4,
                                                width: screenWidth / 1.6,
                                                weatherData: weatherData),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text("${snapshot.error}");
                                        }
                                        return CircularProgressIndicator();
                                      },
                                    )),
                                // SizedBox(height: 10),
                                Container(
                                    // color: Colors.amber,
                                    width: screenWidth / 1.1,
                                    height: screenHeight / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      // color: Colors.yellow,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomText(
                                          textContent: ' 一週天氣預報',
                                          fontSize: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        FutureBuilder<Weathers>(
                                          future: getWeekData(selectedOption),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final weatherData = snapshot.data;
                                              // print(weatherData);
                                              List<Widget> items = [];
                                              final test = weatherData
                                                  .locations[0]
                                                  .weatherElement[0];
                                              // final d = weatherData.toString();
                                              // print('test$d');
                                              for (var weather in test.time) {
                                                final w =
                                                    weather.startTime.weekday;
                                                String formattedDate =
                                                    DateFormat(
                                                            'EEEE', 'zh_Hant')
                                                        .format(
                                                            weather.startTime);
                                                final s =
                                                    weather.startTime.hour;
                                                final e = weather.endTime.hour;
                                                final p = weather
                                                    .elementValue[0].value;
                                                final i = weather
                                                    .elementValue[1].value;

                                                if (s == 18 && e == 06) {
                                                  items.add(ImageTextWidget(
                                                      image: Image.asset(
                                                          'assets/$i.png'),
                                                      text:
                                                          '$formattedDate\n$p'));
                                                }
                                              }

                                              final temp = weatherData
                                                  .locations[0]
                                                  .weatherElement[1]
                                                  .time;
                                              List<Widget> temps = [];
                                              temp.forEach((element) {
                                                final start =
                                                    element.startTime.hour;
                                                final end =
                                                    element.endTime.hour;
                                                final resulttemp = element
                                                    .elementValue[0].value;
                                                String formattedDate =
                                                    DateFormat(
                                                            'EEEE', 'zh_Hant')
                                                        .format(
                                                            element.startTime);
                                                if (start == 18 && end == 06) {
                                                  temps.add(ImageTextWidget(
                                                      image: Image.asset(
                                                          'assets/bodytemp.png'),
                                                      text:
                                                          '$formattedDate\n$resulttemp℃',textcolor: Colors.yellow));
                                                }
                                              });
                                              return Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: Center(
                                                          child: HorizontalLis(
                                                        weatherData: items,
                                                      )),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      child: Center(
                                                          child: HorizontalLis(
                                                        weatherData: temps,
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ],
                                    )),
                              ],
                            )));
                  }))),
    );
  }
}
