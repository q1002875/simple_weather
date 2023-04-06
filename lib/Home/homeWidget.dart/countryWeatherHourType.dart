import 'package:flutter/material.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourIten.dart';
import '../../Cloud/Cloud.dart';

class HorizontalList extends StatefulWidget {

  HorizontalList({this.weatherData});
  final WeatherWeekData weatherData;

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
                
  final List<Widget> items = [
    ImageTextWidget(text: '1232',),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
    ImageTextWidget(),
  ];
  
  get weatherData => weatherData;

  @override
  Widget build(BuildContext context) {

    // print(weatherData);

    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(child: items[index]),
          );
        },
      ),
    );
  }
}
