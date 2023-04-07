import 'package:flutter/material.dart';

class ImageTextWidget extends StatelessWidget {
  final String imageUrl;
  final String text;

  ImageTextWidget({this.imageUrl, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.wind_power, size: 50, color: Colors.yellow),
        // Image(width: 60, height: 40, image: AssetImage('assets/菜單.jpg')),
        SizedBox(height: 5.0),
        Text(text ?? '',
           textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16, // 字体大小
            fontWeight: FontWeight.bold, // 字体粗细
            color: Colors.black, // 字体颜色
            letterSpacing: 1.5, // 字母间距
            wordSpacing: 5.0, // 单词间距
            decorationStyle: TextDecorationStyle.dashed, // 装饰样式
          ),
          )
      ],
    );
  }
}
