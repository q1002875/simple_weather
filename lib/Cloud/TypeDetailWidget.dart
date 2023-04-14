import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:simple_weahter/Cloud/Cloud.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'package:simple_weahter/Home/homePage.dart';

import '../ApiCommand.dart/apiService.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  List<cloudDetailItem> data = [];
  List<ChartData> chartdatas = [];
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('zh_Hant');
    getCloudWeekDetailData(selectedOption, widget.type.Englishname);
  }

  Future<void> getCloudWeekDetailData(String country, String type) async {
    List<cloudDetailItem> datacloud = [];
    final api = apiService();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<ChartData> chartdata = [];

    data.asMap().forEach((key, value) {
      if (value.select) {
        chartdata.add(ChartData(value.weekday, int.parse(value.value), key));
      } else {
        chartdata.add(ChartData(value.weekday, int.parse(value.value), null));
      }
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 74, 57, 131),
          title: Text(widget.type.name),
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
                      Container(
                          margin: EdgeInsets.all(12),
                          width: double.infinity,
                          height: screenWidth / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(174, 139, 98, 162),
                          ),
                          child: SimpleLineChart(chartdata, cloudAllType.UVI)),
                      Container(
                        margin: EdgeInsets.all(12),
                        width: double.infinity,
                        height: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(174, 139, 98, 162),
                        ),
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return CustomText(
                              textContent: data[index].value,
                              textColor: data[index].select
                                  ? Colors.black
                                  : Colors.white,
                            );
                          },
                          itemCount: data.length,
                        ),
                      )
                    ],
                  )));
  }
}

class SimpleLineChart extends StatelessWidget {
  final List<ChartData> data;
  final cloudAllType type;
  SimpleLineChart(this.data, this.type);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderColor: Colors.white.withOpacity(0.2), // 設置繪圖區域邊框顏色和透明度
      backgroundColor: Colors.transparent, // 設置背景為透明
      title: ChartTitle(
        text: type != null ? type.name : cloudAllType.UVI.name, // 設置圖表標題
        textStyle: TextStyle(
          color: Colors.white.withOpacity(0.7), // 設置標題文字顏色和透明度
          fontWeight: FontWeight.bold,
        ),
      ),
      legend: Legend(
        isVisible: false, // 隱藏圖例
      ),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5), // 設置標籤文字顏色和透明度
          fontWeight: FontWeight.bold,
        ),
        majorGridLines: MajorGridLines(
          width: 0, // 隱藏主要網格線
        ),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5), // 設置標籤文字顏色和透明度
          fontWeight: FontWeight.bold,
        ),
        axisLine: AxisLine(width: 0), // 隱藏y軸線
        majorTickLines: MajorTickLines(width: 0), // 隱藏y軸刻度線
        majorGridLines: MajorGridLines(
          color: Colors.white.withOpacity(0.2), // 設置次要網格線顏色和透明度
        ),
      ),
      onMarkerRender: (MarkerRenderArgs args) {
        data.forEach((element) {
          if (element.select != null && element.select == args.pointIndex) {
            args.color = Colors.red;
          }
        });
      },

      series: <LineSeries<ChartData, String>>[
        LineSeries<ChartData, String>(
          color: Color.fromARGB(255, 73, 14, 145), // 設置折線顏色
          width: 8,
          dataSource: data,
          xValueMapper: (ChartData sales, _) => sales.day,
          yValueMapper: (ChartData sales, int index) => sales.value,

          markerSettings: MarkerSettings(
            isVisible: true,
            color: Colors.white, // 設置標記顏色
            width: 12,
            borderColor: Color.fromARGB(255, 73, 14, 145), // 設置標記邊框顏色
            borderWidth: 2, // 設置標記邊框寬度
          ),

          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class ChartData {
  final String day;
  final int value;
  final int select;
  ChartData(this.day, this.value, this.select);
}
