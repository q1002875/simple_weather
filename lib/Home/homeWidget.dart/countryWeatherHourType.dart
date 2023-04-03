import 'package:flutter/material.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourIten.dart';

import 'countryWeatherState.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  final List<Widget> items = [
     ImageTextWidget(),
      ImageTextWidget(),
       ImageTextWidget(),
      ImageTextWidget(),
  ];

  @override
  Widget build(BuildContext context) {
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
            child: Center(
              child: items[index]
            ),
          );
        },
      ),
    );
  }
}
