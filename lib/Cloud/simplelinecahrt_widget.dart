import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Cloud.dart';

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
            args.color = Colors.yellow;
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
