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
          SizedBox(height: 70),
          Container(
            width: screenWidth/2,
            height: screenHeight/2.7,
            color: Colors.purple,
            child: CountryWeather(),
          ),
           SizedBox(height: 30),
            MyListView()
  // Container(
  //           width: screenWidth - 50,
  //           height: screenHeight / 4.5,
  //           color: Colors.yellow,
  //           child: MyListView(),
  //         ),


      
        ],
      ),
          ));
  }
}





