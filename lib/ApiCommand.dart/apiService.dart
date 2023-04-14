import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/ExtensionToolClass/HttpServer/Httpserver.dart';
import '../ApiModel.dart/sunRiseSetModel.dart';
import '../ApiModel.dart/weathersModel.dart';
import '../ApiModel.dart/weathersModel2.dart';
import '../Home/homeWidget.dart/ListWidget/UVIwidget.dart';
import '../Home/homeWidget.dart/ListWidget/weatherHourItem.dart';

//ignore: camel_case_types
class apiService {
  final authkey = 'CWB-95C4A955-4E38-4B86-92B4-2F1E71669956';

  Future<WeatherData> getCountryData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=$authkey&limit=7&format=JSON&locationName=$country&elementName=&sort=time';
    print('getCountryApi:$api');

    final today = HttpService(baseUrl: api);
    final response = await today.getJson();
    return WeatherData.fromJson(response as Map<String, dynamic>);
  }

  Future<WeatherWeekData> getWeekCountryData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx';
    print('getWeekApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    // print('response:$response');

    return WeatherWeekData.fromJson(response as Map<String, dynamic>);
  }

  Future<List<String>> getSunRiseSetTime(String country) async {
    DateTime now = DateTime.now();
    String formattedFromDate = DateFormat('yyyy-MM-dd').format(now); // 格式化日期時間
    DateTime tomorrow = now.add(Duration(days: 1));
    String formattedtoDate = DateFormat('yyyy-MM-dd').format(tomorrow);
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/A-B0062-001?Authorization=$authkey&CountyName=$country&parameter=SunRiseTime,SunSetTime&timeFrom=$formattedFromDate&timeTo=$formattedtoDate';
    print('getSunRiseSetTime:$api');
    final sunData = HttpService(baseUrl: api);
    final response = await sunData.getJson();
    print('sun response:$response');
    final suntimes = SunData.fromJson(response);
    final suntime = suntimes.records.locations.location[0].time[0];
    print('sunnnn$suntime');
    return [suntime.sunRiseTime, suntime.sunSetTime];
  }

  Future<List<List<Widget>>> getWeekData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx,MaxT,MinT';
    print('getWeekApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    // print('response:$response');
    // final test = weatherData.locations[0].weatherElement[0];
    final weathers = Weathers.fromJson(response);
    final wx = weathers.locations[0].weatherElement[0]; //天氣狀況
    final maxT = weathers.locations[0].weatherElement[1]; //最高溫度
    final minT = weathers.locations[0].weatherElement[2]; //最低溫度
    final wxItems = wx.time
        .where((w) => w.startTime.hour == 18 && w.endTime.hour == 6)
        .map((w) => ImageTextWidget(
            image: Image.asset('assets/${w.elementValue[1].value}.png'),
            text:
                '${DateFormat('EEEE', 'zh_Hant').format(w.startTime)}\n${w.elementValue[0].value}'))
        .toList();
    //where 過濾出t.startTime.hour == 18 && t.endTime.hour == 6的物件
    final matItem = minT.time
        .where((t) => t.startTime.hour == 18 && t.endTime.hour == 6)
        .map((t) => ImageTextWidget(
            image: Image.asset('assets/bodytemp.png'),
            text: '${t.elementValue[0].value}',
            textcolor: Colors.yellow))
        .toList();

    final atItems = maxT.time
        .where((t) => t.startTime.hour == 18 && t.endTime.hour == 6)
        .map((t) => ImageTextWidget(
            image: Image.asset('assets/bodytemp.png'),
            text:
                '${DateFormat('EEEE', 'zh_Hant').format(t.startTime)}\n${t.elementValue[0].value}',
            textcolor: Colors.yellow))
        .toList();

    List<String> match = [];

    atItems.asMap().forEach((key, value) {
      match.add(value.text + '°' + '~' + matItem[key].text + '°');
    });

    final minTandMaxT = match
        .map((e) => ImageTextWidget(
            image: Image.asset('assets/bodytemp.png'),
            text: '$e',
            textcolor: Colors.yellow))
        .toList();

    return [wxItems, minTandMaxT];
  }

///////////////////////cloudpage api
  ///
  ///
  ///
  Future<List<Timeweather>> getCloudWeekDetailData(
      String country, String type) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=$type';
    print('getCloudWeekDetailData:$api');
    final weekWeatherDetailData = HttpService(baseUrl: api);
    final response = await weekWeatherDetailData.getJson();
    final weathers = Weathers.fromJson(response);
    final elementName = weathers.locations[0].weatherElement[0].elementName;
    final www = weathers.locations[0].weatherElement[0].time;
    print('weekclouddata:' + elementName + www.toString());
    return www;
  }

  Future<Map<String, dynamic>> getCloudData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=UVI,WS,WD,Td,RH,T';
    print('getWeecloudkApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    // // print('getWeecloudkApi response:$response');
    DateTime now = DateTime.now();

    final weathers = Weathers.fromJson(response);
    final www = weathers.locations[0].weatherElement;
    final Map<String, dynamic> cloudforwidgets = {};

    www.forEach((element) {
      switch (element.description) {
        case '紫外線指數':
          element.time.forEach(
            (element) => {
              //  element.elementValue.forEach((datas) {print
              //  ('紫外線資料'+ element.startTime.toString()+ element.endTime.toString()+
              //   datas.value + datas.measures
              //  ); }),
              if (now.day == element.endTime.day ||
                  now.day + 1 == element.endTime.day)
                {
                  //今日資料
                  cloudforwidgets['UVI'] = UVIWidget(
                      textfirst: element.elementValue[1].value,
                      textsecond: element.elementValue[0].measures +
                          ':' +
                          element.elementValue[0].value,
                      uviLevel: element.elementValue[0].value)
                }
              //do week dats
            },
          );
          break;
        case '平均溫度':
          element.time.forEach(
            (element) => {
              if (now.day == element.endTime.day ||
                  now.day == element.startTime.day)
                {
                  ////今日資料
                  print(element.elementValue[0].value),
                  print(element.elementValue[0].measures),
                  cloudforwidgets['T'] = element.elementValue[0].value
                }
            },
          );
          break;
        case '平均相對濕度':
          print(element.elementName);
          element.time.forEach(
            (element) => {
              if (now.day == element.endTime.day ||
                  now.day == element.startTime.day)
                {
                  ////今日資料
                  print(element.elementValue[0].value),
                  print(element.elementValue[0].measures),
                  cloudforwidgets['RH'] = element.elementValue[0].value
                }
            },
          );
          break;
        case '最大風速':
          print(element.elementName);
          break;
        case '風向':
          print(element.elementName);
          element.time.forEach(
            (element) => {
              if (now.day == element.endTime.day ||
                  now.day == element.startTime.day)
                {
                  ////今日資料
                  print(element.elementValue[0].value),
                  print(element.elementValue[0].measures),
                  cloudforwidgets['WD'] = element.elementValue[0].value
                }
            },
          );

          break;

        case '平均露點溫度':
          print(element.elementName);
          element.time.forEach(
            (element) => {
              if (now.day == element.endTime.day ||
                  now.day == element.startTime.day)
                {
                  ////今日資料
                  print(element.elementValue[0].value),
                  print(element.elementValue[0].measures),
                  cloudforwidgets['Td'] = element.elementValue[0].value
                }
            },
          );
          break;
      }
    });

    return cloudforwidgets;
  }
}

// final users = await httpService.get('users', (json) {
//   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// });
