import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';

class ImageTextWidget extends StatelessWidget {
  final String imageUrl;
  final String text;
  final Color textcolor;
  final Image image;
  ImageTextWidget({this.imageUrl, this.text, this.image,this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 50,
            width: 50,
            child: image != null ? image : Image.asset('assets/raining.png')),
        SizedBox(height: 5.0),
        CustomText(textContent: text, fontSize: 14,textColor: textcolor!= null ?textcolor :Color.fromARGB(255, 255, 255, 255)  ,),
      ],
    );
  }
}
