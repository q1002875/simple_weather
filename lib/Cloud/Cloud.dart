import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../ExtensionToolClass/HttpServer/Httpserver.dart';
class WeatherData {
  String _datasetDescription;
  List<Location> _locations;

  String get datasetDescription => _datasetDescription;
  List<Location> get locations => _locations;

  WeatherData.fromJson(Map<String, dynamic> json) {
    _datasetDescription = json['records']['datasetDescription'];
    _locations = List<Location>.from(
        json['records']['location'].map((location) => Location.fromJson(location)));
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
    _locations = List<Locationweek>.from(json['records']['locations']['location']
        .map((location) => Locationweek.fromJson(location)));
  }
}
class Locationweek {
  String _locationName;
  // List<Weatherweek> _weatherElements;

  String get locationName => _locationName;
  // List<Weatherweek> get weatherElements => _weatherElements;

  Locationweek.fromJson(Map<String, dynamic> json) {
    _locationName = json['locationName'];
    // _weatherElements = List<Weatherweek>.from(
        // json['weatherElement'].map((element) => Weatherweek.fromJson(element)));
  }
}

class Weatherweek {
  String _elementName;
  List<Timeweek> _times;

  String get elementName => _elementName;
  List<Timeweek> get times => _times;

  Weatherweek.fromJson(Map<String, dynamic> json) {
    _elementName = json['elementName'];
    _times = List<Timeweek>.from(json['time'].map((time) => Timeweek.fromJson(time)));
  }
}
class Timeweek {
  DateTime _startTime;
  DateTime _endTime;
  String _parameterValue;
 
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  String get parameterValue => _parameterValue;

  Timeweek.fromJson(Map<String, dynamic> json) {
    _startTime = DateTime.parse(json['startTime']);
    _endTime = DateTime.parse(json['endTime']);
    _parameterValue = json['elementValue'][0]['Value'];
  }
}

// class WeatherData {
//   final List<Location> locations;

//   WeatherData({this.locations});

//   factory WeatherData.fromJson(Map<String, dynamic> json) {
//     List<Location> locations = [];
//     for (var locationJson in json['records']['location']) {
//       locations.add(Location.fromJson(locationJson));
//     }
//     return WeatherData(locations: locations);
//   }
// }

// class Location {
//   final String name;
//   final List<Weather> weather;

//   Location({this.name, this.weather});

//   factory Location.fromJson(Map<String, dynamic> json) {
//     List<Weather> weather = [];
//     for (var weatherJson in json['weatherElement']) {
//       weather.add(Weather.fromJson(weatherJson));
//     }
//     return Location(name: json['locationName'], weather: weather);
//   }
// }

// class Weather {
//   final String elementName;
//   final String description;
//   final List<Time> time;
//   final String weatherState;
//   final String temperature;
//   Weather(
//       {this.description,
//       this.weatherState,
//       this.temperature,
//       this.time,
//       this.elementName});
//   factory Weather.fromJson(Map<String, dynamic> json) {
//     List<Time> t = [];
//      for (var p in json['time']) {
//       t.add(Time.fromJson(p));
//     }
//     return Weather(
//       time: t,
//       description: json['description'],
//       weatherState: json['time'][0]['parameter']['parameterName'],
//       temperature: json['time'][0]['parameter']['parameterName'],
//     );
//   }
// }


// class Time {
//   DateTime _startTime;
//   DateTime _endTime;
//   String _parameterName;
//   String _parameterValue;
//   String _parameterUnit;

//   DateTime get startTime => _startTime;
//   DateTime get endTime => _endTime;
//   String get parameterName => _parameterName;
//   String get parameterValue => _parameterValue;
//   String get parameterUnit => _parameterUnit;

//   Time.fromJson(Map<String, dynamic> json) {
//     _startTime = DateTime.parse(json['startTime']);
//     _endTime = DateTime.parse(json['endTime']);
//     _parameterName = json['parameter']['parameterName'];
//     _parameterValue = json['parameter']['parameterValue'];
//     _parameterUnit = json['parameter']['parameterUnit'] ?? '';
//   }
// }

// class TimeWeather {
//   final String startTime;
//   final String endTime;
//   final List<Parameter> parameter;
//   final List<elementValue> elementvalue;
//   TimeWeather(
//       {this.startTime, this.endTime, this.parameter, this.elementvalue});
//   factory TimeWeather.fromJson(Map<String, dynamic> json) {
//     List<Parameter> par = [];
//     for (var p in json['parameter']) {
//       par.add(Parameter.fromJson(p));
//     }

//     List<elementValue> ele = [];
//     for (var p in json['elementValue']) {
//       ele.add(elementValue.fromJson(p));
//     }

//     return TimeWeather(
//      startTime: json['startTime'],
//      endTime: json['endTIme'],
//      parameter: par,
//      elementvalue: ele
//     );
//   }
// }

// class elementValue {
//   final String value;
//   final String measures;
//   elementValue({this.value, this.measures});
//   factory elementValue.fromJson(Map<String, dynamic> json) {
//     return elementValue(
//       value: json['value'],
//       measures: json['measures'],
//     );
//   }
// }

// class Parameter {
//   final String name;
//   final String unit;
//   Parameter({this.name, this.unit});
//   factory Parameter.fromJson(Map<String, dynamic> json) {
//     return Parameter(
//       name: json['parameterName'],
//       unit: json['parameterUnit'],
//     );
//   }
// }

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
                      subtitle: Text(
                          location.weatherElements[index]._elementName.toString() ??
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
