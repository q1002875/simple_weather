import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import 'package:simple_weahter/HttpServer/HttpServerModel.dart';
import 'package:simple_weahter/HttpServer/Httpserver.dart';
import 'homeWidget.dart/countryWeatherHourType.dart';
import 'homeWidget.dart/countryWeatherState.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.title});
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}



// ignore: missing_return
Future<WeatherData> getcountryData() async {
  final api = apiService();
  final countrydata = await api.getCountryData('新竹縣');
  return  countrydata;
  final loacls = countrydata.locations;
  print('here $loacls');
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
        body: Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            width: screenWidth / 1.6,
            height: screenHeight / 2.2,
            // color: Colors.purple,
            child: FutureBuilder<WeatherData>(
      future: getcountryData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final weatherData = snapshot.data;
          return Container(
            child:  CountryWeather(height:screenHeight / 2.4,width: screenWidth / 1.6,weatherData: weatherData),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    )
                 ),
          SizedBox(height: 30),
          Container(
             width: screenWidth/1.1,
            height: screenHeight / 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // color: Colors.yellow,
            ),
            child: Center(
              child: HorizontalList()
            ),
          ),
          SizedBox(height: 5),
          Container(
             width: screenWidth/1.1,
            height: screenHeight / 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // color: Colors.blue,
            ),
            child: Center(
              child:HorizontalList()
            ),
          )
        ],
      ),
    ));
  }
}
