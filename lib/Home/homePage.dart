import 'package:flutter/material.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import 'homeWidget.dart/countryWeatherHourType.dart';
import 'homeWidget.dart/countryWeatherState.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.title});
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: missing_return
Future<WeatherData> getcountryData(String country) async {
  final api = apiService();
  final countrydata = await api.getCountryData(country);
  return countrydata;
}

Future<WeatherWeekData> getweekcountryData(String country) async {
  final api = apiService();
  final data = await api.getWeekCountryData(country);
  final dddd = data.locations[0].locationName;
  print('heeee$dddd');
  return data;
}

class _HomePageState extends State<HomePage> {
  Future<void> _onRefresh() async {
    setState() {
      print('reflash');
    }
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

    //  storageService.init().then((_) {
    //   final data = storageService.loadData('country');
    //     print('data here$data');
    //   setState(() {
    //     selectedOption = data as String ?? '新竹縣';
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return MaterialApp(
      title: 'Flutter Pull-to-Refresh',
      home: Scaffold(
          body: SafeArea(
        child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: Scaffold(
                body: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50),
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
                          // storageService.saveData('country',newValue);
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
                  SizedBox(height: 30),
                  Container(
                      width: screenWidth / 1.1,
                      height: screenHeight / 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: Colors.yellow,
                      ),
                      child: FutureBuilder<WeatherWeekData>(
                        future: getweekcountryData(selectedOption),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final weatherData = snapshot.data;
                            return Container(
                              child: Center(child: HorizontalList(weatherData: weatherData,)),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        },
                      )),
                  SizedBox(height: 5),
                  Container(
                    width: screenWidth / 1.1,
                    height: screenHeight / 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // color: Colors.blue,
                    ),
                    child: Center(child: HorizontalList()),
                  )
                ],
              ),
            ))),
      )),
    );
  }
}
