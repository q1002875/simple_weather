import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/ApiModel.dart/weatherAlertModel.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourItem.dart';

import '../ExtensionToolClass/ShowDialog.dart';

enum WeatherCondition {
  foggy, //   濃霧
  heavyRain, // 大雨
  torrentialRain, // 豪雨
  heavyTorrentialRain, // 大豪雨
  superTorrentialRain, // 超大豪雨
  strongWindOnLand, // 陸上強風
}

extension WeatherConditionExtension on WeatherCondition {
  // ignore: missing_return
  Image get conditionImage {
    switch (this) {
      case WeatherCondition.foggy:
        return Image.asset('assets/raining.png');
      case WeatherCondition.heavyRain:
        return Image.asset('assets/01.png');
      case WeatherCondition.torrentialRain:
        return Image.asset('assets/02.png');
      case WeatherCondition.heavyTorrentialRain:
        return Image.asset('assets/03.png');
      case WeatherCondition.superTorrentialRain:
        return Image.asset('assets/04.png');
      case WeatherCondition.strongWindOnLand:
        return Image.asset('assets/05.png');
    }
  }
}

class AlertPage extends StatefulWidget {
  final String title;
  const AlertPage({this.title});

  @override
  _AlertPageState createState() => _AlertPageState();
}

Future<Records> getAlertReport() async {
  final api = apiService();
  final data = api.getAlertReport();

  return data;
}

class _AlertPageState extends State<AlertPage> {
  @override
  initState() {
    super.initState();
// getAlertReport();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 74, 57, 131),
          title: Text('各地特報')),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/homeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: FutureBuilder<Records>(
              future: getAlertReport(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final weatherReport = snapshot.data.record;
                  return Container(
                    width: screenWidth,
                    height: screenHeight,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: weatherReport.length,
                        itemBuilder: (BuildContext context, int index) {
                          final descrption =
                              weatherReport[index].datasetInfo.datasetDescription;
                          final detailcontent =
                              weatherReport[index].contents.content.contentText;

                           final info = weatherReport[index].hazardConditions.hazards.hazard[0].info;
                           final nameList = info.affectedAreas.location;

                          return Container(
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 18, 54, 96),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      height: screenHeight / 12, // 設置標題視圖的高度
                                      child: CustomText(
                                        textContent: descrption,
                                        textColor: Colors.white,
                                        fontSize: 22,
                                      ) // 在這裡放置自定義的標題視圖
                                      ),
                                  Container(
                                      width: screenWidth,
                                      height: (screenHeight / 8) *
                                          weatherReport.length,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: nameList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                showCustomDialog(
                                                    context,
                                                    '警示特報',
                                                    detailcontent.replaceAll('\\n', ''),
                                                    Colors.yellow,
                                                    Colors.white);
                                                print(index);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 74, 57, 131),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                height: screenHeight / 8,
                                                width: screenWidth,
                                                child: AlertItemWidget(
                                                  data: info,
                                                  height: screenHeight,
                                                  width: screenWidth,index: index,
                                                ),
                                              ),
                                            );
                                          }))
                                ],
                              ));
                        }),
                  );
                } else if (snapshot.hasError) {
                  print("地方特報頁面錯誤:${snapshot.error}");
                  return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 74, 57, 131),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: screenHeight / 8,
                      width: screenWidth,
                      child: CustomText(
                        textContent: '今日無地方特報',
                        textColor: Colors.white,
                        fontSize: 22,
                      ));
                  // Text()
                }
                return CircularProgressIndicator();
              },
            ),
          )),
    );
  }
}

class AlertItemWidget extends StatelessWidget {
  final Info data;
  final int index;
  final double width;
  final double height;

  AlertItemWidget({this.data, this.height, this.width,this.index});

  // ignore: missing_return
  WeatherCondition showImage(String state) {
    switch (state) {
      case '濃霧':
        return WeatherCondition.foggy;
      case '大雨':
        return WeatherCondition.heavyRain;
      case '豪雨':
        return WeatherCondition.torrentialRain;
      case '大豪雨':
        return WeatherCondition.heavyTorrentialRain;
      case '超大豪雨':
        return WeatherCondition.superTorrentialRain;
      case '陸上強風':
        return WeatherCondition.strongWindOnLand;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final issue = data.;
    // String formattedDate =
        // DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(issue));
    final localname = data.affectedAreas.location[index].locationName;
    final state = data.phenomena;
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.horizontal,
      children: [
        ///時間
        Expanded(
          flex: 1,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  flex: 1,
                  child: CustomText(
                    textContent: '事件時間',
                    textColor: Colors.white,
                    fontSize: 18,
                  )),
              Flexible(
                  flex: 1,
                  child: CustomText(
                    textContent: 'formattedDate',
                    textColor: Colors.white,
                    fontSize: 18,
                  ))
            ],
          ),
        ),

        ///地區
        Expanded(
          flex: 1,
          child: Container(
            child: CustomText(
              textContent: localname,
              textColor: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        //特警狀態
        Expanded(
          flex: 1,
          child: Container(
            child: ImageTextWidget(
              text: state,
              image: showImage(state).conditionImage,
            ),
          ),
        )
      ],
    );
  }
}
