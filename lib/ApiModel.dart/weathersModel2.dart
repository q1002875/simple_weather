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
///
///
///

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
