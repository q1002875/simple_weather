import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../ApiModel.dart/weathersModel2.dart';
import '../../ExtensionToolClass/CustomText.dart';
import 'ListWidget/weatherHourItem.dart';

class CountryWeather extends StatelessWidget {
  CountryWeather({this.width, this.height, this.weatherData});

  final double width;
  final double height;
  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    //image

    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('yyyy-MM-dd', 'zh_Hant').format(now); // 格式化日期時間
    print(formattedDate);
    final weatherStatus =
        weatherData.locations[0].weatherElements[0].times[0].parameterName;

    String weatherimage =
        weatherData.locations[0].weatherElements[0].times[0].parameterValue;
    int myInt = int.parse(weatherimage);
    if (myInt < 10) {
      weatherimage = '0$weatherimage';
    }

    final rain =
        weatherData.locations[0].weatherElements[1].times[0].parameterName;
    final temperature =
        weatherData.locations[0].weatherElements[2].times[0].parameterName;
    final conforStatus =
        weatherData.locations[0].weatherElements[3].times[0].parameterName;
    print('天氣狀態:$weatherStatus');
    print('溫度:$temperature');
    print('舒適度:$conforStatus');
    print('降雨機率:$rain');

    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/$weatherimage.png', width: 200, height: height / 3),
        CustomText(
          textContent: '$temperature℃',
          textColor: Colors.yellow,
          fontSize: 40,
        ),
        CustomText(
          textContent: formattedDate,
          textColor: Colors.white,
          fontSize: 18,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InfoContainer(
                image: Image.asset('assets/$weatherimage.png'),
                text: '$weatherStatus',
                width: width / 2.8,
                height: height / 3.5),
            InfoContainer(
                image: Image.asset('assets/bodytemp.png'),
                text: '$conforStatus',
                width: width / 2.8,
                height: height / 3.5),
            InfoContainer(
                image: Image.asset('assets/raining.png'),
                text: '降雨機率$rain%',
                width: width / 2.8,
                height: height / 3.3),
          ],
        ),
      ],
    ));
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key key,
    this.image,
    this.text,
    this.width,
    this.height,
  }) : super(key: key);

  final Image image;
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 74, 57, 131),
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: width,
      height: height,
      child: Center(
        child: ImageTextWidget(
          image: image,
          text: text,
        ),
      ),
    );
  }
}
