import 'package:flutter/material.dart';

class HorizontalLis extends StatelessWidget {

  final double screen ;

  HorizontalLis({this.weatherData,this.screen});
  List<Widget> weatherData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screen/4.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: screen / 5.5,
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 74, 57, 131),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(child: weatherData[index]),
          );
        },
      ),
    );
  }
}
