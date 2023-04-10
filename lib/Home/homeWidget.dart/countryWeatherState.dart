import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
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
    final tt =
        weatherData.locations[0].weatherElements[0].times[0].parameterName;
    final conforStatus =
        weatherData.locations[0].weatherElements[3].times[0].parameterName;
    print('天氣狀態:$weatherStatus');
    print('溫度:$temperature');
    print('舒適度:$conforStatus');
    print('降雨機率:$rain');

    return Container(
        child: ListView.builder(
      itemCount: 4,
      // ignore: missing_return
      itemBuilder: (context, index) {
        if (index == 0) {
          // 顯示天氣狀態和溫度
          return Container(
            width: 200,
            height: height / 2.5,
            child: Image(
              image: AssetImage('assets/$weatherimage.png'),
            ),
          );
        } else if (index == 1) {
          // 顯示溫度
          return Container(
            width: 200,
            height: height / 8,
            child: Center(
              child: CustomText(
                textContent: '$temperature℃',
                textColor: Colors.yellow,
                fontSize: 40,
              ),
            ),
          );
        } else if (index == 2) {
          // 顯示日期
          return Container(
            width: 200,
            height: height / 9.5,
            child: Center(
              child: CustomText(
                textContent: '$formattedDate',
                fontSize: 18,
              ),
            ),
          );
        } else if (index == 3) {
          // 顯示三個資訊欄位
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InfoContainer(
                image: Image.asset('assets/$weatherimage.png'),
                text: '$weatherStatus',
                width: width / 3.3,
                height: height / 3.4,
              ),
              InfoContainer(
                image: Image.asset('assets/bodytemp.png'),
                text: '$conforStatus',
                width: width / 3.3,
                height: height / 3.4,
              ),
              InfoContainer(
                image: Image.asset('assets/raining.png'),
                text: '降雨機率$rain%',
                width: width / 3.3,
                height: height / 3.4,
              ),
            ],
          );
        }
      },
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




