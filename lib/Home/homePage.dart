import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import '../ExtensionToolClass/CustomText.dart';
import '../ExtensionToolClass/StorageService.dart';
import 'homeWidget.dart/ListWidget/weatherHourItem.dart';
import 'homeWidget.dart/countryWeatherHourType.dart';
import 'homeWidget.dart/countryWeatherState.dart';

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

Future<WeatherWeekData> getweekcountryData(String country) async {
  final data = await api.getWeekCountryData(country);
  // final dddd = data.locations[0].locationName;
  return data;
}

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

// await storage.init();

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
          body: SafeArea(
        child: 
        FutureBuilder<String>(
    future: _storageService.loadData('country'),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        setState(() {
              selectedOption = snapshot.data;
        });
      }
      return ListView(
        children: [RefreshIndicator(
            onRefresh: _onRefresh,
            child: Scaffold(
                body: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 25),
                  Container(
                      child: Center(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.5,
                              wordSpacing: 5.0,
                              decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          selectedOption = newValue;
                            _storageService.saveData('country', newValue);

                        });
                      },
                    ),
                  )),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  Container(
                      width: screenWidth / 1.1,
                      height: screenHeight / 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: Colors.yellow,
                      ),
                      child: Column(
                        children: [
                          CustomText(textContent: ' 一週天氣預報',fontSize: 20,),
                          SizedBox(height: 20,),
                          FutureBuilder<WeatherWeekData>(
                            future: getweekcountryData(selectedOption),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final weatherData = snapshot.data;
                                final List<Widget> items = [];
                                final test =
                                    weatherData.locations[0].weatherElements[0];

                                for (var weather in test.times) {
                                  final w = weather.startTime.weekday;
                                  String formattedDate =
                                      DateFormat('EEEE', 'zh_Hant')
                                          .format(weather.startTime);
                                  final s = weather.startTime.hour;
                                  final e = weather.endTime.hour;
                                  final p = weather.parameterValue;
                                  final i = weather.imageValue;

                                  if (s == 18 && e == 06) {
                                    items.add(ImageTextWidget(
                                        text: '$formattedDate\n$p'));
                                  }
                                }
                                return Container(
                                  child: Center(
                                      child: HorizontalLis(
                                    weatherData: items,
                                  )),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return CircularProgressIndicator();
                            },
                          )
                        ],
                      )),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth / 1.1,
                    height: screenHeight / 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // color: Colors.blue,
                    ),
                    child: Center(
                        child: HorizontalLis(
                      weatherData: push,
                    )),
                  )
                ],
              ),
            )))],
      );
      
      
      
        
      }
      )
        
        
        
       
      )),
    );
  }
}
