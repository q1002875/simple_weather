import 'package:flutter/material.dart';

class CountryWeather extends StatelessWidget {
  const CountryWeather({this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hello World!', // 文本内容
          style: TextStyle(
            fontSize: 24, // 字体大小
            fontWeight: FontWeight.bold, // 字体粗细
            fontStyle: FontStyle.italic, // 字体样式
            color: Colors.blue, // 字体颜色
            letterSpacing: 1.5, // 字母间距
            wordSpacing: 5.0, // 单词间距
            decoration: TextDecoration.underline, // 字体装饰
            decorationColor: Colors.red, // 装饰颜色
            decorationStyle: TextDecorationStyle.dashed, // 装饰样式
          ),
        ),
        Container(
          width: 200,
          height: 200,
          child: Icon(Icons.cloud, size: 150, color: Colors.blue),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 主軸對齊方式
          crossAxisAlignment: CrossAxisAlignment.center, // 交叉軸對齊方式
          children: <Widget>[
            Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'Search Page',
                  ),
                )),
            //sizedbox是指定堅格距離
            SizedBox(width: 5),
            // Spacer(),
            Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
            //spacer是平均分配間隔
            SizedBox(width: 5),
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
