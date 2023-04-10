import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/ExtensionToolClass/HttpServer/Httpserver.dart';
import '../ApiModel.dart/weathersModel.dart';
import '../Cloud/Cloud.dart';
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

  Future<List<List<Widget>>> getWeekData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx,MaxT,MinT';
    print('getWeekApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    // print('response:$response');
    // final test = weatherData.locations[0].weatherElement[0];
    final weathers =  Weathers.fromJson(response);
    final wx =  weathers.locations[0].weatherElement[0];//天氣狀況
    final maxT = weathers.locations[0].weatherElement[1];//最高溫度
    final minT = weathers.locations[0].weatherElement[2];//最低溫度
      final wxItems = wx.time
        .where((w) => w.startTime.hour == 18 && w.endTime.hour == 6)
        .map((w) => ImageTextWidget(
            image: Image.asset('assets/${w.elementValue[1].value}.png'),
            text:
                '${DateFormat('EEEE', 'zh_Hant').format(w.startTime)}\n${w.elementValue[0].value}'))
        .toList();
    //where 過濾出t.startTime.hour == 18 && t.endTime.hour == 6的物件
    final atItems = maxT.time
        .where((t) => t.startTime.hour == 18 && t.endTime.hour == 6)
        .map((t) => ImageTextWidget(
            image: Image.asset('assets/bodytemp.png'),
            text:
                '${DateFormat('EEEE', 'zh_Hant').format(t.startTime)}\n${t.elementValue[0].value}℃',
            textcolor: Colors.yellow))
        .toList();

    final matItem = minT.time.where((t)=> t.startTime.hour == 18 && t.endTime.hour == 6) .map((t) => ImageTextWidget(
            image: Image.asset('assets/bodytemp.png'),
            text:
                '${DateFormat('EEEE', 'zh_Hant').format(t.startTime)}\n${t.elementValue[0].value}',
            textcolor: Colors.yellow))
        .toList();
     print('matItem$matItem');
    
List<String> match = [];

matItem.map((e) => match.add(e.text +'℃'+'~'+ atItems[e.index].text+'℃'));

final result =  match.map((e)=> ImageTextWidget(
            image: Image.asset('assets/bodytemp.png'),
            text:
                '$e',
            textcolor: Colors.yellow))
        .toList();


    return [wxItems, result];
    // List<Widget> wxitems = [];
    // for (var weather in wx.time) {
    //   String formattedDate =
    //       DateFormat('EEEE', 'zh_Hant').format(weather.startTime);
    //   final s = weather.startTime.hour;
    //   final e = weather.endTime.hour;
    //   final p = weather.elementValue[0].value;
    //   final i = weather.elementValue[1].value;

    //   if (s == 18 && e == 06) {
    //     wxitems.add(ImageTextWidget(
    //         image: Image.asset('assets/$i.png'), text: '$formattedDate\n$p'));
    //   }
    // }

    // List<Widget> atitems = [];
    // maxT.time.forEach((element) {
    //   final start = element.startTime.hour;
    //   final end = element.endTime.hour;
    //   final resulttemp = element.elementValue[0].value;
    //   String formattedDate =
    //       DateFormat('EEEE', 'zh_Hant').format(element.startTime);
    //   if (start == 18 && end == 06) {
    //     atitems.add(ImageTextWidget(
    //         image: Image.asset('assets/bodytemp.png'),
    //         text: '$formattedDate\n$resulttemp℃',
    //         textcolor: Colors.yellow));
    //   }
    // });


    // // List<Widget> mintitems = [];
    // // minT.time.forEach((element) {
    // //   final start = element.startTime.hour;
    // //   final end = element.endTime.hour;
    // //   final resulttemp = element.elementValue[0].value;
    // //   String formattedDate =
    // //       DateFormat('EEEE', 'zh_Hant').format(element.startTime);
    // //   if (start == 18 && end == 06) {
    // //     atitems.add(ImageTextWidget(
    // //         image: Image.asset('assets/bodytemp.png'),
    // //         text: '$formattedDate\n$resulttemp℃',
    // //         textcolor: Colors.yellow));
    // //   }
    // // });

    //  List<List<Widget>> fetchwidget = [];
    //  fetchwidget.add(wxitems);
    //  fetchwidget.add(atitems);
    // //  fetchwidget.add(mintitems);
    // return fetchwidget;
    // // return Weathers.fromJson(response);
  }
}

// final users = await httpService.get('users', (json) {
//   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// });