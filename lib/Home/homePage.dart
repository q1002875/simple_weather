import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:localization/localization.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/ExtensionToolClass/ShowDialog.dart';
import '../ApiModel.dart/weathersModel2.dart';
import '../ExtensionToolClass/CustomText.dart';
import '../ExtensionToolClass/StorageService.dart';
import 'homeWidget.dart/countryWeatherHourType.dart';
import 'homeWidget.dart/countryWeatherState.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

enum WeaterStatusType {
  Wx, //天氣狀態
  MaxT //最低溫
}

String selectedOption = '新竹縣'; //預設

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

Future<List<List<Widget>>> getWeekData(String country) async {
  final data = await api.getWeekData(country);
  // final resultdata = data.toString();
  // print('resultdata$resultdata');
  return data;
}

// ignore: missing_return

class _HomePageState extends State<HomePage> {


  Future<void> _onRefresh() async {
    setState() {
      print('object');
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
  String local = '';
  @override
  initState() {
    super.initState();
    initializeDateFormatting('zh_Hant');
    _loadCountryName();
    getLocation(options);
  }

// ignore: missing_return
  Future<String> getLocation(List<String> options) async {
    // 檢查權限
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // 沒有權限，不能獲取位置信息
        return '';
      }
    }

    // 獲取當前位置
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // 獲取地址信息
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // 獲取縣市信息
    String city = placemarks[0].subAdministrativeArea;
    if (options.contains(city)) {
      local = city;
    } else {
      return '';
    }
  }

  void _loadCountryName() async {
    String countryName =
        await SharedPreferencesHelper.getString('country', defaultValue: '新竹縣');
    setState(() {
      selectedOption = countryName;
    });
  }

  void _saveCountryName(String newValue) async {
    await SharedPreferencesHelper.setString('country', newValue);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return MaterialApp(
      title: 'Flutter Pull-to-Refresh',
      home: Scaffold(
          body: Container(
              child: RefreshIndicator(
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
                                  child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: screenWidth,
                                    height: 80,
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.black26,
                                      value: selectedOption,
                                      items: options.map((String option) {
                                        return DropdownMenuItem<String>(
                                          value: option,
                                          child: CustomText(
                                              textContent: option.i18n(),
                                              fontSize: 30),
                                        );
                                      }).toList(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _saveCountryName(newValue);
                                          selectedOption = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                              child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (local != '') {
                                                  _saveCountryName(local);
                                                  selectedOption = local;
                                                } else {
                                                  showCustomDialog(
                                                      context,
                                                      '定位錯誤',
                                                      '請重新檢查定位',
                                                      Colors.black,
                                                      Colors.black);
                                                }
                                              });
                                            },
                                            child: Image.asset(
                                              'assets/location.png',
                                              width: 150,
                                              height: 150,
                                            ),
                                          )
                                              
                                          ))
                                ],
                              ),
                            ],
                          ))),
                          Container(
                              width: screenWidth / 1.6,
                              height: screenHeight / 1.8,
                              child: FutureBuilder<WeatherData>(
                                future: getcountryData(selectedOption),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final weatherData = snapshot.data;
                                    return Container(
                                      child: CountryWeather(
                                          height: screenHeight / 1.8,
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
                              height: screenHeight / 1.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                // color: Colors.yellow,
                              ),
                              child: Column(
                                children: [
                                  CustomText(
                                    textContent:'一週天氣預報',
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FutureBuilder<List<List<Widget>>>(
                                    future: getWeekData(selectedOption),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final weatherData = snapshot.data;
                                        return Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: Center(
                                                    child: HorizontalLis(
                                                  screen: screenHeight / 1.3,
                                                  weatherData: weatherData[0],
                                                )),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              CustomText(
                                                textContent: '一週體感預報',
                                                fontSize: 20,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                child: Center(
                                                    child: HorizontalLis(
                                                  screen: screenHeight / 1.3,
                                                  weatherData: weatherData[1],
                                                )),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              // Container(
                                              //   child: Center(
                                              //       child: HorizontalLis(
                                              //     weatherData:
                                              //         weatherData[2],
                                              //   )),
                                              // ),
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
                      ))))),
    );
  }
}
