import 'package:flutter/material.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourIten.dart';
import '../../Cloud/Cloud.dart';

class HorizontalLis extends StatelessWidget {
  HorizontalLis({this.weatherData});
  List<Widget> weatherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(child: weatherData[index]),
          );
        },
      ),
    );
  }
}
