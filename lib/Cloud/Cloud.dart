import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  String _datasetDescription;
  List<Location> _locations;

  String get datasetDescription => _datasetDescription;
  List<Location> get locations => _locations;

  WeatherData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Location>.from(json['records']['location']
        .map((location) => Location.fromJson(location)));
  }
}

class Location {
  String _locationName;
  List<Weather> _weatherElements;

  String get locationName => _locationName;
  List<Weather> get weatherElements => _weatherElements;

  Location.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    _weatherElements = List<Weather>.from(
        json['weatherElement'].map((element) => Weather.fromJson(element)));
  }
}

class Weather {
  String _elementName;
  List<Time> _times;

  String get elementName => _elementName;
  List<Time> get times => _times;

  Weather.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Time>.from(json['time'].map((time) => Time.fromJson(time)));
  }
}

class Time {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterName;
  String _parameterValue;
  String _parameterUnit;

  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterName => _parameterName;
  String get parameterValue => _parameterValue;
  String get parameterUnit => _parameterUnit;

  Time.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterName = json['parameter']['parameterName'];
    _parameterValue = json['parameter']['parameterValue'];
    _parameterUnit = json['parameter']['parameterUnit'] ?? '';
  }
}

///////////////week data

class WeatherWeekData {
  String _datasetDescription;
  List<Locationweek> _locations;

  String get datasetDescription => _datasetDescription;
  List<Locationweek> get locations => _locations;

  WeatherWeekData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Locationweek>.from(json['records']['locations'][0]
            ['location']
        .map((location) => Locationweek.fromJson(location)));
  }
  @override
  String toString() {
    return 'WeatherWeekData(datasetDescription: $datasetDescription, locations: $locations)';
  }
}

class Locationweek {
  String _locationName;
  List<Weatherweek> _weatherElements;

  String get locationName => _locationName;
  List<Weatherweek> get weatherElements => _weatherElements;

  Locationweek.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    _weatherElements = List<Weatherweek>.from(
        json['weatherElement'].map((element) => Weatherweek.fromJson(element)));
  }
  @override
  String toString() {
    return 'Locationweek(locationName: $locationName, weatherElements: $weatherElements)';
  }
}

class Weatherweek {
  String _elementName;
  List<Timeweek> _times;

  String get elementName => _elementName;
  List<Timeweek> get times => _times;

  Weatherweek.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Timeweek>.from(
        json['time'].map((time) => Timeweek.fromJson(time)));
  }
  @override
  String toString() {
    return 'Weatherweek(elementName: $elementName, times: $times)';
  }
}

class Timeweek {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterValue;
  String _imageValue;
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterValue => _parameterValue;
  String get imageValue => _imageValue;
  Timeweek.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterValue = json['elementValue'][0]['value'];
    _imageValue = json['elementValue'][1]['value'];
  }
  @override
  String toString() {
    return 'Timeweek(startTime: $startTime, endTime: $endTime,parameterValue:$parameterValue,imageValue:$imageValue)';
  }
}
///////////////////////result week get


Future<http.Response> fetchWeatherData(String country) async {
  final String apiUrl =
      'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-95C4A955-4E38-4B86-92B4-2F1E71669956&limit=7&format=JSON&locationName=$country&elementName=&sort=time&timeTo=2023-04-03T20%3A00%3A00';
// final httpService  = HttpService(baseUrl: apiUrl);

// final response = await httpService.getJson();
// final usersJson = response['data'] as List<dynamic>;
// final users = usersJson.map((userJson) => User.fromJson(userJson)).toList();

  try {
    return await http.get(Uri.parse(apiUrl));
  } catch (e) {
    // Handle the exception
    print('Failed to fetch weather data: $e');
    rethrow;
  }
}

class Cloud extends StatelessWidget {
  const Cloud();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<http.Response>(
            future: fetchWeatherData('嘉義縣'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var jsonData = jsonDecode(snapshot.data.body);
                print(jsonData.toString());
                var weatherData = WeatherData.fromJson(jsonData);
                print(weatherData.toString());
                return ListView.builder(
                  itemCount: weatherData.locations.length,
                  itemBuilder: (context, index) {
                    var location = weatherData.locations[index];
                    return ListTile(
                      title: Text(location._locationName ?? ""),
                      subtitle: Text(location
                              .weatherElements[index]._elementName
                              .toString() ??
                          ""),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
