import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';

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
        CustomText(textContent: text,fontSize: 16),
      ],
    );
  }
}
