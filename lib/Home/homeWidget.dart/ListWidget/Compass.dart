
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:simple_weahter/ExtensionToolClass/CustomText.dart';


enum CompassDirection { N, NE, E, SE, S, SW, W, NW }
extension ParseCompassDirection on CompassDirection {
  static CompassDirection fromString(String str) {
    switch (str) {
      case '偏北風':
        return CompassDirection.N;
      case '東北風':
        return CompassDirection.NE;
      case '偏東風':
        return CompassDirection.E;
      case '東南風':
        return CompassDirection.SE;
      case '偏南風':
        return CompassDirection.S;
      case '西南風':
        return CompassDirection.SW;
      case '偏西風':
        return CompassDirection.W;
      case '西北風':
        return CompassDirection.NW;
      default:
        return CompassDirection.NW;
    }
  }
}
class CompassWidget extends StatelessWidget {
  final CompassDirection direction;
  final double size;

  CompassWidget({this.direction, this.size}) : assert(size > 0);

  @override
  Widget build(BuildContext context) {
    final radius = size / 2;
    final textSize = radius / 3;
    // final pointerSize = radius / 3;

    return Center(
      child: Container(
        width: size,
        height: size,
        child: Stack(
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(193, 108, 82, 183),
                 border: Border.all(
                  color: Colors.grey,
                  width: 5.0,
                ),
              ),
            ),
            Positioned(
              left: radius - textSize / 2,
              top: 0,
              child: CustomText(textContent: '北',textColor: Colors.white,fontSize: 24,)
            ),
            Positioned(
              left: radius - textSize / 2,
              bottom: 0,
              child: CustomText(textContent: '南',textColor: Colors.white,fontSize: 24,)
       
            ),
            Positioned(
              left: textSize / 2,
              top: radius - textSize,
              child: CustomText(textContent: '西',textColor: Colors.white,fontSize: 24,)
   
            ),
            Positioned(
              right: textSize / 2,
              top: radius - textSize,
              child: CustomText(textContent: '東',textColor: Colors.white,fontSize: 24,)
            ),
            Container(
              width: size,
              height: size,
              child: ClockHand(angle: _getPointerAngle(direction)),
            )
          ],
        ),
      ),
    );
  }

  double _getPointerAngle(CompassDirection direction) {
    switch (direction) {
      case CompassDirection.N:
        return 0;
      case CompassDirection.NE:
        return 45;
      case CompassDirection.E:
        return 90;
      case CompassDirection.SE:
        return 135;
      case CompassDirection.S:
        return 180;
      case CompassDirection.SW:
        return -135;
      case CompassDirection.W:
        return -90;
      case CompassDirection.NW:
        return -45;
      default:
        return 0;
    }
  }
}



class ClockHand extends StatelessWidget {
  final double angle;
  final double size;
  final Color color;

  ClockHand({this.angle, this.size = 1, this.color = Colors.redAccent});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * math.pi / 180,
      child: CustomPaint(
        painter: _HandPainter(color),
        size: Size.square(size),
      ),
    );
  }
}

class _HandPainter extends CustomPainter {
  final Color color;

  _HandPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 8

      ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, center.translate(0, -size.width / 5), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
