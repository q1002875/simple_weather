import 'package:flutter/material.dart';

class ImageTextWidget extends StatelessWidget {
  final String imageUrl;
  final String text;

  ImageTextWidget({this.imageUrl,  this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Image(image: AssetImage('assets/菜單.jpg')),
        SizedBox(height: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
