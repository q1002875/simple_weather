import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import 'package:simple_weahter/Cloud/simplelinecahrt_widget.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Home/homePage.dart';
import '../ApiCommand.dart/apiService.dart';
import '../ApiModel.dart/sunRiseSetModel.dart';
import '../Home/homeWidget.dart/ListWidget/Compass.dart';
import '../Home/homeWidget.dart/ListWidget/UVIwidget.dart';

class cloudDetailItem {
  String daynumber;
  String weekday;
  String value;
  bool select;
  cloudDetailItem(
      {this.daynumber, this.weekday, this.select = false, this.value = ''});
}

class MyModalPage extends StatefulWidget {
  final cloudAllType type;
  const MyModalPage({Key key, this.type = cloudAllType.UVI}) : super(key: key);
  @override
  _MyModalPageState createState() => _MyModalPageState();
}

class _MyModalPageState extends State<MyModalPage> {
  final api = apiService();
  List<cloudDetailItem> data = [];
  // List<ChartData> chartdatas = [];
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('zh_Hant');

    if (widget.type == cloudAllType.SUN) {
      getCloudWeekSunDetailData(selectedOption);
    } else {
      getCloudWeekDetailData(selectedOption, widget.type.Englishname);
    }
  }

  Future<void> getCloudWeekSunDetailData(String country) async {
    List<cloudDetailItem> datacloud = [];

    List<SunDataTime> rise = await api.getSunWeekRiseSetTime(country);

    rise.forEach((element) {
      DateTime date = DateTime.parse(element.date);
      String formattedDate =
          DateFormat('EEEE', 'zh_Hant').format(date).replaceAll('星期', '');

      final sunrise = element.sunRiseTime;
      final sunset = element.sunSetTime;
      final day = date.day;
      datacloud.add(cloudDetailItem(
          value: '$sunrise-$sunset',
          daynumber: formattedDate,
          weekday: '$day',
          select: false));
    });
    setState(() {
      data = datacloud;
    });
  }

  Future<void> getCloudWeekDetailData(String country, String type) async {
    List<cloudDetailItem> datacloud = [];

    final clouddata = await api.getCloudWeekDetailData(country, type);
    print(clouddata.toString());
    clouddata.forEach((element) {
      element.elementValue.forEach((e) {
        print(e.value + e.measures);
        final daystartTime = element.startTime.day;
        final dayendTime = element.endTime.day;
        DateTime now = element.startTime;
        String formattedDate =
            DateFormat('EEEE', 'zh_Hant').format(now).replaceAll('星期', '');

        datacloud.add(cloudDetailItem(
            value: e.value,
            daynumber: '$formattedDate',
            weekday: '$dayendTime',
            select: false));
      });
    });
    //去除重複的值
    List<cloudDetailItem> filteredDatacloud = [];
    Set<String> daynumbers = {};
    for (cloudDetailItem item in datacloud) {
      if (!daynumbers.contains(item.daynumber)) {
        daynumbers.add(item.daynumber);
        filteredDatacloud.add(item);
      }
    }

    setState(() {
      data = filteredDatacloud;
      wdString = data[0].value;
      print(data.toString());
    });
  }

  String wdString;
  @override
  Widget build(BuildContext context) {
    // String wdString;
    final screenWidth = MediaQuery.of(context).size.width;
    List<ChartData> chartdata = [];
//////風向資料
    data.asMap().forEach((key, value) {
      if (widget.type == cloudAllType.WD || widget.type == cloudAllType.SUN) {
        chartdata.add(ChartData(value.weekday, 0, null));
      } else {
        if (value.select) {
          chartdata
              .add(ChartData(value.weekday, int.parse(value.value ?? 0), key));
        } else {
          chartdata
              .add(ChartData(value.weekday, int.parse(value.value ?? 0), null));
        }
      }
    });

    chartdata.forEach((element) {
      print(element.value.toString());
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 74, 57, 131),
          title: Text(selectedOption + ' ' + widget.type.name),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homeBackground.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: data == []
                ? CircularProgressIndicator()
                : ListView(
                  
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 100,
                          // color: Colors.amberAccent,
                          // width: double.infinity, // or use fixed width
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              cloudDetailItem value = data[index];
                              final onetext = value.daynumber;
                              final twotext = value.weekday;
                              final select = value.select;

                              return GestureDetector(
                                onTap: () {
                                  data.asMap().forEach((key, value) {
                                    data[key].select = false;
                                  });
                                  setState(() {
                                    data[index].select = true;
                                    wdString = data[index].value;
                                    print(data[index].value);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomText(
                                        textContent: '$onetext',
                                        textColor: Colors.white,
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: select
                                              ? Colors.white
                                              : Color.fromARGB(
                                                  0, 255, 255, 255),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomText(
                                              textContent: '$twotext',
                                              textColor: select
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),

                           widget.type != cloudAllType.SUN ?   Container(
                          margin: EdgeInsets.all(12),
                          width: double.infinity,
                          height: screenWidth / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(174, 139, 98, 162),
                          ),
                          child: widget.type == cloudAllType.WD
                              ? CompassWidget(
                                  size: screenWidth / 2,
                                  direction: ParseCompassDirection.fromString(
                                      wdString ?? '偏北風'))
                              : SimpleLineChart(chartdata, widget.type)) :
                              Spacer(flex: 1,),
                   
                      Container(
                          margin: EdgeInsets.all(12),
                          width: double.infinity,
                          height: screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(174, 139, 98, 162),
                          ),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              widget.type == cloudAllType.SUN
                                  ? Flexible(flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                flex: 3,
                                                child: CustomText(
                                                  textColor:Colors.white,
                                                  textContent: '    ',
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: CustomText(
                                                  textColor: Colors.white,
                                                  textContent: '  日出',
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Expanded(
                                                flex:  3,
                                                child:  CustomText(
                                                        textColor: Colors.white,
                                                        textContent: ' 日落',
                                                        fontSize: 22,
                                                      ),
                                              ),
                                            ],
                                          ),
                                    )
                                  : SizedBox(
                                      height: 0,
                                      width: 0,
                                    ),
                              Flexible(flex: 8,
                                child: ListView.builder(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return cloudDetailText(
                                        data: data[index],
                                        select: data[index].select,
                                        type: widget.type,
                                        screenheight: ((screenWidth / 1.3) /
                                            data.length));
                                  },
                                  itemCount: data.length,
                                ),
                              ),
                            ],
                          ))
                    ],
                  )));
  }
}

// ignore: camel_case_types
class cloudDetailText extends StatelessWidget {
  // final List<cloudDetailItem> data;
  final cloudDetailItem data;
  final bool select;
  final cloudAllType type;
  final double screenheight;
  cloudDetailText(
      {this.data,
      this.select,
      this.type = cloudAllType.UVI,
      this.screenheight});

  @override
  Widget build(BuildContext context) {
    final day = data.daynumber;
    final week = data.weekday;
    final value = data.value;
    final property = type.property;
    final detailtext =
        returnCloudDataText(type: type, value: value).showDetailtext();
    // ignore: missing_return
    String showTypetext() {
      switch (type) {
        case cloudAllType.UVI:
          return '$property: $value';
        case cloudAllType.SUN:
          List<String> substrings = value.split("-");
          return substrings[0];
        case cloudAllType.WD:
          return value;
        case cloudAllType.T:
          return '$value° $property';
        case cloudAllType.Td:
          return '$value° $property';
        case cloudAllType.RH:
          return '$value $property';
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 3,
        ),
        Container(
            height: screenheight,
            child:type != cloudAllType.WD ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 3,
                  child: CustomText(
                    // align: TextAlign.left,
                    textColor: select ? Colors.yellow : Colors.white,
                    textContent: '週$day',
                    fontSize: 22,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: CustomText(
                    textColor: select ? Colors.yellow : Colors.white,
                    textContent: showTypetext(),
                    fontSize: 22,
                  ),
                ),
                Expanded(
                  flex: type == cloudAllType.UVI ? 5 : 3,
                  child: type == cloudAllType.UVI
                      ? Container(
                          margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                          child:
                              GradientBar(whiteDotPositions: int.parse(value)),
                        )
                      : CustomText(
                          textColor: select ? Colors.yellow : Colors.white,
                          textContent:detailtext,
                          fontSize: 22,
                        ),
                ),
              ],
            )
            : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 3,
                        child: CustomText(
                          // align: TextAlign.left,
                          textColor: select ? Colors.yellow : Colors.white,
                          textContent: '週$day',
                          fontSize: 22,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: CustomText(
                          textColor: select ? Colors.yellow : Colors.white,
                          textContent: showTypetext(),
                          fontSize: 22,
                        ),
                      ),
                    ],
                  )
            
            ),
        SizedBox(
          height: 3,
        ),
        Container(
          height: 2,
          width: screenheight * 8.5,
          color: Colors.white,
        )
      ],
    );
  }
}

class returnCloudDataText {
  final cloudAllType type;
  final String value;
  returnCloudDataText({this.type, this.value});

  String showDetailtext() {
    int temp;
    try {
      temp = int.parse(value);
    } on FormatException catch (e) {
      print('Failed to parse: ${e.message}');
    }
    switch (type) {
      case cloudAllType.SUN:
        List<String> substrings = value.split("-");
        return substrings[1];
      case cloudAllType.WD:
        return value;

      case cloudAllType.T:
        if (temp <= 25) {
          return '舒適溫度';
        } else if (temp >= 26 && temp <= 29) {
          return '略微悶熱';
        } else if (temp >= 30 && temp <= 34) {
          return '明顯的悶熱';
        } else if (temp >= 35 && temp <= 39) {
          return '非常悶熱';
        } else if (temp >= 40) {
          return '極度炎熱';
        } else {
          return '';
        }
        break;
      case cloudAllType.Td:
        if (temp <= 15) {
          return '相對濕度較低';
        } else if (temp >= 16 && temp <= 18) {
          return '相對濕度適中';
        } else if (temp >= 19 && temp <= 22) {
          return '相對濕度較高';
        } else if (temp >= 23 && temp <= 25) {
          return '相對濕度高';
        } else if (temp >= 26) {
          return '相對濕度極高';
        } else {
          return '';
        }

        break;
      case cloudAllType.RH:
        if (temp <= 30) {
          return '相對濕度過低';
        } else if (temp >= 30 && temp <= 60) {
          return '相對濕度適中';
        } else {
          return '相對濕度過高';
        }
        break;
    }
  }
}
