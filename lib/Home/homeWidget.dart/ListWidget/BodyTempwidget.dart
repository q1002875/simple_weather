import 'package:flutter/material.dart';
import 'dart:math' as math;
class TemperatureIcon extends StatelessWidget {
  final double temperature;
  final double size;

  TemperatureIcon({ this.temperature, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _TemperatureIconPainter(temperature),
      ),
    );
  }
}

class _TemperatureIconPainter extends CustomPainter {
  final double temperature;

  _TemperatureIconPainter(this.temperature);

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2;

    // Draw background circle
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), radius, backgroundPaint);

    // Draw temperature indicator
    Paint indicatorPaint = Paint()
      ..color = _getIndicatorColor()
      ..style = PaintingStyle.fill;
    double indicatorSize = radius * 0.6;
    canvas.drawCircle(Offset(centerX, centerY), indicatorSize, indicatorPaint);

    // Draw temperature text
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: temperature.toStringAsFixed(1),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
        canvas,
        Offset(
            centerX - textPainter.width / 2, centerY - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Color _getIndicatorColor() {
    if (temperature < 0) {
      return Colors.blue;
    } else if (temperature < 20) {
      return Colors.green;
    } else if (temperature < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}


class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen();
  @override 
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  double _temperature = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Temperature',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '$_temperature °C',
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      _temperature--;
                    });
                  },
                ),
                SizedBox(width: 16.0),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _temperature++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Thermometer extends StatelessWidget {
  final double temperature;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color mercuryColor;

 const Thermometer({
     this.temperature,
    this.height = 200,
    this.width = 50,
    this.backgroundColor = Colors.grey,
    this.mercuryColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ThermometerPainter(
        temperature: temperature,
        height: height,
        width: width,
        backgroundColor: backgroundColor,
        mercuryColor: mercuryColor,
      ),
      child: Container(
        height: height,
        width: width,
      ),
    );
  }
}

class ThermometerPainter extends CustomPainter {
  final double temperature;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color mercuryColor;

  ThermometerPainter({
     this.temperature,
     this.height,
     this.width,
     this.backgroundColor,
     this.mercuryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()..color = backgroundColor;
    Paint mercuryPaint = Paint()..color = mercuryColor;

    // Draw background
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, width, height), Radius.circular(10)),
        backgroundPaint);

    // Draw thermometer tube
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(5, 5, width - 10, height - 10), Radius.circular(5)),
        mercuryPaint);

    // Draw mercury
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(10, height * temperature / 100 - 5, width - 20, 10),
            Radius.circular(5)),
        mercuryPaint);

    // Draw temperature text
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${temperature.toStringAsFixed(1)} °C',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: mercuryColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset((width - textPainter.width) / 2, 20));

    // Draw arc
    double arcRadius = width / 2;
    double arcAngle = math.asin(arcRadius / (height - 10));
    double arcStartAngle = math.pi / 2 - arcAngle;
    double arcEndAngle = math.pi / 2 + arcAngle;
    Path arcPath = Path()
      ..addArc(
          Rect.fromCircle(
              center: Offset(width / 2, height - 5), radius: arcRadius),
          arcStartAngle,
          arcEndAngle - arcStartAngle)
      ..lineTo(width / 2 + arcRadius, height)
      ..lineTo(width / 2 - arcRadius, height)
      ..close();
    canvas.drawPath(arcPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
