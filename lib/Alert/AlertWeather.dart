// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:simple_weahter/ApiCommand.dart/apiService.dart';
import 'package:simple_weahter/ApiModel.dart/weatherAlertModel.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Home/homeWidget.dart/ListWidget/weatherHourItem.dart';

import '../ExtensionToolClass/ShowDialog.dart';

Future<Records> getAlertReport() async {
  final api = apiService();
  final jsonMap = api.getAlertReport();
  return jsonMap;
}

class AlertItemWidget extends StatelessWidget {
  String headerTitle;
  String issueTime;
  String state;
  final double width;
  final double height;

  AlertItemWidget({
    this.headerTitle,
    this.issueTime,
    this.state,
    this.height = 100,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    // final issue = data.;
    String formattedDate =
        DateFormat('MM-dd hh:mm').format(DateTime.parse(issueTime));
    // final localname = data.affectedAreas.location[index].locationName;

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
                  flex: 4,
                  child: CustomText(
                    textContent: '時間',
                    textColor: Colors.white,
                    fontSize: 18,
                  )),
              Flexible(
                  flex: 6,
                  child: CustomText(
                    textContent: formattedDate,
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
              textContent: headerTitle,
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
}

class AlertPage extends StatefulWidget {
  final String title;
  const AlertPage({this.title});

  @override
  _AlertPageState createState() => _AlertPageState();
}

class Item {
  AlertItemWidget headerValue;
  WarpAreaWidget expandedValue;
  Item({this.headerValue, this.expandedValue});
}

class WarpAreaWidget extends StatelessWidget {
  List<Location> data;
  WarpAreaWidget(this.data);
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          color: Colors.white,
          child: Wrap(
              direction: Axis.horizontal,
              spacing: 2.0,
              runSpacing: 4.0,
              children: data
                  .map((e) => Chip(
                        backgroundColor: const Color.fromARGB(255, 74, 57, 131),
                        label: CustomText(
                          textContent: e.locationName,
                          fontSize: 20,
                          textColor: Colors.white,
                        ),
                      ))
                  .toList()),
        )
      ],
    );
  }
}

enum WeatherCondition {
  foggy, //   濃霧
  heavyRain, // 大雨
  torrentialRain, // 豪雨
  heavyTorrentialRain, // 大豪雨
  superTorrentialRain, // 超大豪雨
  strongWindOnLand, // 陸上強風
}

class _AlertPageState extends State<AlertPage> {
  String contentText = '';

  int _currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 74, 57, 131),
          actions: [
            contentText != ''
                ? IconButton(
                    icon: Icon(Icons.warning),
                    onPressed: () {
                      showCustomDialog(context, '警示', contentText,
                          Color.fromARGB(255, 255, 236, 67), Colors.black);
                      // 在這裡添加按鈕點擊後的操作
                    },
                  )
                : Container()
          ],
          title: Text('各地特報'.i18n())),
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
                if (snapshot.hasData && snapshot.data.record.length != 0) {
                  List<Item> _items = [];
                  final weatherReport = snapshot.data.record;
                  final datas =
                      weatherReport[0].hazardConditions.hazards.hazard;
                  final dataInfo = weatherReport[0].datasetInfo;
                  contentText = weatherReport[0].contents.content.contentText;
                  final issueTime = dataInfo.issueTime;

                  datas.forEach((element) {
                    final headerTitle = element.info.phenomena +
                        '\n' +
                        element.info.significance;
                    final localtions = element.info.affectedAreas.location;
                    AlertItemWidget alert = AlertItemWidget(
                      headerTitle: headerTitle,
                      issueTime: issueTime,
                      state: element.info.phenomena,
                    );
                    WarpAreaWidget warp = WarpAreaWidget(localtions);
                    Item save = Item(headerValue: alert, expandedValue: warp);
                    _items.add(save);
                  });
                  return SingleChildScrollView(
                    child: Container(
                      child: ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 500),
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            _currentIndex = isExpanded ? -1 : index;
                          });
                        },
                        children: _items.map<ExpansionPanel>((Item item) {
                          return ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Container(
                                  color: const Color.fromARGB(255, 74, 57, 131),
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 18, 54, 96),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Container(
                                        height: screenHeight / 8,
                                        width: screenWidth,
                                        child: item.headerValue,
                                      )));
                            },
                            body: Container(
                              margin: EdgeInsets.all(8),
                              height: (item.expandedValue.data.length) < 9
                                  ? screenHeight / 10
                                  : screenHeight / 8,
                              //  (item.expandedValue.data.length) ,
                              width: screenWidth,
                              child: Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 1, child: item.expandedValue)
                                  ]),
                            ),
                            isExpanded: _currentIndex == _items.indexOf(item),
                          );
                        }).toList(),
                      ),
                    ),
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
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Container(
                      width: 10,
                      height: screenHeight / 8,
                      child: CircularProgressIndicator());
                } else {
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
                }
              },
            ),
          )),
    );
  }

  @override
  initState() {
    super.initState();
    // getAlertReport();
  }
}

extension WeatherConditionExtension on WeatherCondition {
  Image get conditionImage {
    switch (this) {
      case WeatherCondition.foggy:
        return Image.asset('assets/raining.png');
      case WeatherCondition.heavyRain:
        return Image.asset('assets/raining.png');
      case WeatherCondition.torrentialRain:
        return Image.asset('assets/raining.png');
      case WeatherCondition.heavyTorrentialRain:
        return Image.asset('assets/raining.png');
      case WeatherCondition.superTorrentialRain:
        return Image.asset('assets/raining.png');
      case WeatherCondition.strongWindOnLand:
        return Image.asset('assets/raining.png');
    }
  }
}
