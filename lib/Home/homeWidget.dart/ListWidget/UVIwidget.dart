import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';
import 'dart:math' as math;

class UVIWidget extends StatelessWidget {
  final String uviLevel;
  final String textfirst;
  final String textsecond;
  UVIWidget({this.uviLevel, this.textfirst, this.textsecond});

  @override
  Widget build(BuildContext context) {
    print('uviLevel=' + uviLevel);
    return Column(
      //
      children: [
        SizedBox(height: 5.0),
        CustomText(
          textContent: textfirst,
          fontSize: 20,
        ),
        SizedBox(height: 15.0),
        CustomText(
          textContent: textsecond,
          fontSize: 20,
        ),
        SizedBox(height: 20.0),
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: GradientBar(whiteDotPositions: int.parse(uviLevel)),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class GradientBar extends StatelessWidget {
  int whiteDotPositions;
  GradientBar({this.whiteDotPositions}) {
    if (whiteDotPositions < 1) {
      this.whiteDotPositions = 1;
    } else if (whiteDotPositions > 10) {
      this.whiteDotPositions = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              width: 20.0,
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

// class Compass extends StatelessWidget {
//   final String direction;

//   Compass({this.direction});

//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: _getAngle(),
//       child:
//           // Image.asset('compass.png'), // 可以自行替換成自己的圖片
//           Pointer(angle: math.pi / 4, size: 20, color: Colors.red),
//     );
//   }

//   double _getAngle() {
//     switch (direction) {
//       case '北':
//         return 0;
//       case '東北':
//         return -math.pi / 4;
//       case '東':
//         return -math.pi / 2;
//       case '東南':
//         return -3 * math.pi / 4;
//       case '南':
//         return math.pi;
//       case '西南':
//         return 3 * math.pi / 4;
//       case '西':
//         return math.pi / 2;
//       case '西北':
//         return math.pi / 4;
//       default:
//         return 0;
//     }
//   }
// }

class CompassWidget extends StatefulWidget {
  final String direction;

  CompassWidget({this.direction});

  @override
  _CompassWidgetState createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  final Pointer _pointer = Pointer();
  AssetImage _backgroundImage;

  @override
  void initState() {
    super.initState();
    switch (widget.direction) {
      case 'N':
        _backgroundImage = AssetImage('assets/01.png');
        break;
      case 'E':
        _backgroundImage = AssetImage('assets/01.png');
        break;
      case 'S':
        _backgroundImage = AssetImage('assets/01.png');
        break;
      case 'W':
        _backgroundImage = AssetImage('assets/01.png');
        break;
      default:
        throw Exception('Invalid direction: ${widget.direction}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _pointer.rotate(details.delta.dx / 100);
          });
        },
        child: Stack(
          children: [
            Image(image: _backgroundImage),
            Positioned(
              left: 100,
              top: 100,
              child: Transform.rotate(
                angle: _pointer.angle,
                child: Container(
                  width: 10,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pointer {
  double _angle = 0;

  double get angle => _angle;

  void rotate(double delta) {
    _angle += delta;
    _angle %= 2 * pi;
  }

  Point<double> get position {
    const double radius = 80;
    double x = radius * cos(_angle);
    double y = radius * sin(_angle);
    return Point(x, y);
  }
}
