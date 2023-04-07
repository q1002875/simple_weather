import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';

import '../../ExtensionToolClass/CustomText.dart';

class CountryWeather extends StatelessWidget {
  CountryWeather({this.width, this.height, this.weatherData});

  final double width;
  final double height;
  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    //image

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd','zh_Hant').format(now); // 格式化日期時間
    print(formattedDate);
    final weatherStatus =
        weatherData.locations[0].weatherElements[0].times[0].parameterName;
    final rain =
        weatherData.locations[0].weatherElements[1].times[0].parameterName;
    final temperature =
        weatherData.locations[0].weatherElements[2].times[0].parameterName;
    final tt =
        weatherData.locations[0].weatherElements[0].times[0].parameterName;
    final conforStatus =
        weatherData.locations[0].weatherElements[3].times[0].parameterName;
    print('天氣狀態:$weatherStatus');
    print('溫度:$temperature');
    print('舒適度:$conforStatus');
    print('降雨機率:$rain');


    return Column(
      children: [
        Container(
          width: 200,
          height: height / 2.5,
          child: Icon(Icons.cloud, size: 150, color: Colors.blue),
        ),
        Container(
            width: 200,
            height: height / 8,
            // color: Color.fromARGB(70, 255, 235, 59),
            child: Center(
              child:CustomText(textContent:'$temperature℃',textColor: Colors.yellow,fontSize: 40, ),
            )),
        Container(
            width: 200,
            height: height / 9.5,
            // color: Colors.yellow,
            child: Center(
              child: 
              CustomText(textContent:'$formattedDate',textColor: Colors.black,fontSize: 18, ),
            )),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 主軸對齊方式
          // crossAxisAlignment: CrossAxisAlignment.center, // 交叉軸對齊方式
          children: <Widget>[
            Container(
                width: width / 3.3,
                height: height / 3.4,
                color: Color.fromARGB(255, 230, 37, 37),
                child: Center(
                  child:
                     CustomText(textContent:'$weatherStatus',textColor: Colors.black,fontSize: 18),
                )),
            SizedBox(width: 5),
            Container(
              width: width / 3.3,
              height: height / 3.4,
              color: Colors.green,
              child: Center(
                child: 
                  CustomText(textContent:'$conforStatus',textColor: Colors.black,fontSize: 18),
              ),
            ),
            SizedBox(width: 5),
            Container(
              width: width / 3.3,
              height: height / 3.4,
              color: Color.fromARGB(255, 25, 136, 228),
              child: Center(
                child: 
                 CustomText(textContent:'降雨機率$rain%',textColor: Colors.black,fontSize: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
