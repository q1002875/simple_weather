import 'package:flutter/material.dart';
import '../ApiModel.dart/weathersModel2.dart';

class ReusableFutureBuilder extends StatefulWidget {
  final Future<dynamic> future;
  final Widget Function(dynamic) builder;

  ReusableFutureBuilder(
      {this.future, this.builder, Future<WeatherWeekData> futrue});

  @override
  _ReusableFutureBuilderState createState() => _ReusableFutureBuilderState();
}

class _ReusableFutureBuilderState extends State<ReusableFutureBuilder> {
  Future<dynamic> _future;
  @override
  void initState() {
    super.initState();
    _future = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return widget.builder(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
