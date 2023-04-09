import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';

class ImageTextWidget extends StatelessWidget {
  final String imageUrl;
  final String text;
  final Image image;
  ImageTextWidget({this.imageUrl, this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      //
      children: [
        Container(
            height: 50,
            width: 50,
            child: image != null ? image : Image.asset('assets/raining.png')),
        // Image(width: 60, height: 40, image: AssetImage('assets/菜單.jpg')),
        SizedBox(height: 5.0),
        CustomText(textContent: text, fontSize: 14),
      ],
    );
  }
}
