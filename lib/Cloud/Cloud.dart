import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherData {
  final List<Location> locations;

  WeatherData({ this.locations});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    List<Location> locations = [];
    for (var locationJson in json['records']['location']) {
      locations.add(Location.fromJson(locationJson));
    }
    return WeatherData(locations: locations);
  }
}

class Location {
  final String name;
  final List<Weather> weather;

  Location({ this.name,  this.weather});

  factory Location.fromJson(Map<String, dynamic> json) {
    List<Weather> weather = [];
    for (var weatherJson in json['weatherElement']) {
      weather.add(Weather.fromJson(weatherJson));
    }
    return Location(name: json['locationName'], weather: weather);
  }
}

class Weather {
  final String description;
  final String temperature;

  Weather({ this.description,  this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
      temperature: json['time'][0]['parameter']['parameterName'],
    );
  }
}

Future<http.Response> fetchWeatherData(String country) async {
  final String apiUrl = 'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-95C4A955-4E38-4B86-92B4-2F1E71669956&limit=7&format=JSON&locationName=$country&elementName=&sort=time&timeTo=2023-04-03T20%3A00%3A00';
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
                      title: Text(location.name ?? ""),
                      subtitle: Text(location.weather[index].temperature.toString() ?? ""),
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
