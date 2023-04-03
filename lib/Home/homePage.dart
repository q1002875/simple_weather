import 'package:flutter/material.dart';
import 'homeWidget.dart/countryWeatherHourType.dart';
import 'homeWidget.dart/countryWeatherState.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.title});
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
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
            height: screenHeight / 2.4,
            color: Colors.purple,
            child: CountryWeather(),
          ),
          SizedBox(height: 30),
          Container(
             width: screenWidth/1.1,
            height: screenHeight / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.yellow,
            ),
            child: Center(
              child: HorizontalList()
            ),
          ),
          SizedBox(height: 30),
          Container(
             width: screenWidth/1.1,
            height: screenHeight / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blue,
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
