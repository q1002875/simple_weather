import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';

class UVIWidget extends StatelessWidget {
  final String uviLevel;
  final String textfirst;
  final String textsecond;
  UVIWidget({this.uviLevel, this.textfirst, this.textsecond});

  @override
  Widget build(BuildContext context) {
    print('uviLevel=' + uviLevel);

    return 
    Container( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 3,
          child: CustomText(
            textContent: textfirst,
            fontSize: 20,
          ),
        ),
        Flexible(
          flex: 3,
          child: CustomText(
            textContent: textsecond,
            fontSize: 20,
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: GradientBar(whiteDotPositions: int.parse(uviLevel)),
          ),
        )
      ],
    ));
    
    
  }
}

// ignore: must_be_immutable
class GradientBar extends StatelessWidget {
  int whiteDotPositions;
  double width ;
  GradientBar({this.whiteDotPositions,this.width}) {
    if (whiteDotPositions < 1) {
      this.whiteDotPositions = 1;
    } else if (whiteDotPositions > 10) {
      this.whiteDotPositions = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      // width: width,
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          colors: [
            Colors.green[300],
            Colors.green[400],
            Colors.yellow[400],
            Colors.orange[400],
            Colors.red[400],
            Colors.purple[400],
            Colors.purple[800],
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 1; i <= 10; i++)
            Container(
              width: (screenWidth / 3) / 10,
              height: 20.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == whiteDotPositions
                    ? Color.fromARGB(255, 254, 254, 254)
                    : Color.fromARGB(0, 255, 255, 255),
              ),
            ),
        ],
      ),
    );
  }
}
