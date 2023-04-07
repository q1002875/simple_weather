import 'package:flutter/material.dart';

class HorizontalLis extends StatelessWidget {
  HorizontalLis({this.weatherData});
  List<Widget> weatherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 130.0,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 160, 209, 234),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(child: weatherData[index]),
          );
        },
      ),
    );
  }
}
