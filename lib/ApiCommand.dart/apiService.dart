import 'package:simple_weahter/ExtensionToolClass/HttpServer/Httpserver.dart';
import '../Cloud/Cloud.dart';

//ignore: camel_case_types
class apiService {
  final authkey = 'CWB-95C4A955-4E38-4B86-92B4-2F1E71669956';

  Future<WeatherData> getCountryData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=$authkey&limit=7&format=JSON&locationName=$country&elementName=&sort=time';
    print('getCountryApi:$api');

    final today = HttpService(baseUrl: api);
    final response = await today.getJson();
    return WeatherData.fromJson(response as Map<String, dynamic>);
  }

  Future<WeatherWeekData> getWeekCountryData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx';
    print('getWeekApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    // print('response:$response');

    return WeatherWeekData.fromJson(response as Map<String, dynamic>);
  }

  Future<Weathers> getWeekData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx,MaxT';
    print('getWeekApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    // print('response:$response');
    final ss = Weathers.fromJson(response).toString();
    print('ss$ss');

    return Weathers.fromJson(response);
  }
}
class Weathers {
  final String datasetDescription;
  final String locationsName;
  final String dataid;
  final List<Location> locations;

  Weathers({
     this.datasetDescription,
     this.locationsName,
     this.dataid,
     this.locations,
  });

  factory Weathers.fromJson(Map<String, dynamic> json) {
    List<Location> locations = [];
    for (var location in json['records']['locations'][0]['location']) {
      locations.add(Location.fromJson(location));
    }

    return Weathers(
      datasetDescription: json['records']['locations'][0]['datasetDescription'],
      locationsName: json['records']['locations'][0]['locationsName'],
      dataid: json['records']['locations'][0]['dataid'],
      locations: locations,
    );
  }
}

class Location {
  final String locationName;
  final String geocode;
  final String lat;
  final String lon;
  final List<WeatherElement> weatherElement;

  Location({
     this.locationName,
     this.geocode,
     this.lat,
     this.lon,
     this.weatherElement,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    List<WeatherElement> weatherElement = [];
    for (var element in json['weatherElement']) {
      weatherElement.add(WeatherElement.fromJson(element));
    }

    return Location(
      locationName: json['locationName'],
      geocode: json['geocode'],
      lat: json['lat'],
      lon: json['lon'],
      weatherElement: weatherElement,
    );
  }
}

class WeatherElement {
  final String elementName;
  final String description;
  final List<Timeweather> time;

  WeatherElement({
     this.elementName,
     this.description,
     this.time,
  });

  factory WeatherElement.fromJson(Map<String, dynamic> json) {
    List<Timeweather> time = [];
    for (var t in json['time']) {
      time.add(Timeweather.fromJson(t));
    }

    return WeatherElement(
      elementName: json['elementName'],
      description: json['description'],
      time: time,
    );
  }
}

class Timeweather {
  final DateTime startTime;
  final DateTime endTime;
  final List<ElementValue> elementValue;

  Timeweather({
     this.startTime,
     this.endTime,
     this.elementValue,
  });

  factory Timeweather.fromJson(Map<String, dynamic> json) {
    List<ElementValue> elementValue = [];
    for (var v in json['elementValue']) {
      elementValue.add(ElementValue.fromJson(v));
    }

    return Timeweather(
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      elementValue: elementValue,
    );
  }
}

class ElementValue {
  final String value;
  final String measures;

  ElementValue({
     this.value,
     this.measures,
  });

  factory ElementValue.fromJson(Map<String, dynamic> json) {
    return ElementValue(
      value: json['value'],
      measures: json['measures'],
    );
  }
}



// final users = await httpService.get('users', (json) {
//   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// });