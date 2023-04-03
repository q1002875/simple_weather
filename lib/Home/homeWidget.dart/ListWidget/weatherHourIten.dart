import 'package:flutter/material.dart';

class ImageTextWidget extends StatelessWidget {
  final String imageUrl;
  final String text;

  ImageTextWidget({this.imageUrl, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.sunny, size: 50, color: Colors.yellow),
        // Image(width: 60, height: 40, image: AssetImage('assets/菜單.jpg')),
        SizedBox(height: 5.0),
        Text('PM4')
      ],
    );
  }
}
