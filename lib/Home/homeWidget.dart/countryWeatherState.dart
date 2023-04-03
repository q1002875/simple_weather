import 'package:flutter/material.dart';

class CountryWeather extends StatelessWidget {
  const CountryWeather({this.title,this.width,this.height});
  final String title;

final double width;
final double height;


  @override
  Widget build(BuildContext context) {

    print(title);
    return Column(
      children: [
        Text(
          '新竹縣', // 文本内容
          style: TextStyle(
            fontSize: 24, // 字体大小
            fontWeight: FontWeight.bold, // 字体粗细
            // fontStyle: FontStyle.italic, // 字体样式
            color: Colors.black, // 字体颜色
            letterSpacing: 1.5, // 字母间距
            wordSpacing: 5.0, // 单词间距
            // decoration: TextDecoration.underline, // 字体装饰
            // decorationColor: Colors.red, // 装饰颜色
            decorationStyle: TextDecorationStyle.dashed, // 装饰样式
          ),
        ),
        Container(
          width: 200,
          height: height/2.5,
          child: Icon(Icons.cloud, size: 150, color: Colors.blue),
        ),
          Container(
          width: 200,
          height: height/8,
          color: Colors.yellow,
          child: Center(child: Text(
          '20.c', // 文本内容
          style: TextStyle(
            fontSize: 24, // 字体大小
            fontWeight: FontWeight.bold, // 字体粗细
            // fontStyle: FontStyle.italic, // 字体样式
            color: Colors.black, // 字体颜色
            letterSpacing: 1.5, // 字母间距
            wordSpacing: 5.0, // 单词间距
            // decoration: TextDecoration.underline, // 字体装饰
            // decorationColor: Colors.red, // 装饰颜色
            decorationStyle: TextDecorationStyle.dashed, // 装饰样式
          ),
        ),) 
        ),
         SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 主軸對齊方式
          // crossAxisAlignment: CrossAxisAlignment.center, // 交叉軸對齊方式
          children: <Widget>[
            Container(
                width: width/3.3,
                height:  height/3.4,
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
              width: width/3.3,
              height: height/3.4,
              color: Colors.green,
              child: Center(child: Text('bbbbbb')),
            ),
            // Spacer(),
            // spacer是平均分配間隔
            SizedBox(width: 5),
            Container(
              width: width/3.3,
              height:  height/3.4,
              color: Color.fromARGB(255, 25, 136, 228),
              child: Center(child: Text('ccccc')),
            ),
          ],
        ),
      ],
    );
  }
}
