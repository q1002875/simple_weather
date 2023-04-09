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

  Future<WeatherForecast> getWeekData(String country) async {
    final api =
        'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx,MaxT';
    // print('getWeekApi:$api');
    final weekWeatherData = HttpService(baseUrl: api);
    final response = await weekWeatherData.getJson();
    print('response:$response');
    final ss = WeatherForecast.fromJson(response);
    print('ss$ss');

    return WeatherForecast.fromJson(response);
  }
}

class WeatherForecast {
  Result result;

  WeatherForecast({this.result});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  Records records;
  Result({this.records});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      records: Records.fromJson(json['records']),
    );
  }
}

class Records {
  List<Location> locations;
  Records({this.locations});
  factory Records.fromJson(Map<String, dynamic> json) {
    return Records(
      locations: List<Location>.from(
          json['locations'].map((x) => Location.fromJson(x))),
    );
  }
}

class Location {
  String datasetDescription;
  String locationsName;
  String dataid;
  List<WeatherElement> weatherElement;

  Location(
      {this.datasetDescription,
      this.locationsName,
      this.dataid,
      this.weatherElement});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      datasetDescription: json['datasetDescription'] ?? '',
      locationsName: json['locationsName'] ?? '',
      dataid: json['dataid'] ?? '',
      weatherElement: List<WeatherElement>.from(json['location'][0]
              ['weatherElement']
          .map((x) => WeatherElement.fromJson(x))),
    );
  }
}

class WeatherElement {
  String elementName;
  String description;
  List<Time> time;

  WeatherElement({this.elementName, this.description, this.time});

  factory WeatherElement.fromJson(Map<String, dynamic> json) {
    return WeatherElement(
      elementName: json['elementName'] ?? '',
      description: json['description'] ?? '',
      time: List<Time>.from(json['time'].map((x) => Time.fromJson(x))),
    );
  }
}

class Time {
  DateTime startTime;
  DateTime endTime;
  List<ElementValue> elementValue;

  Time({this.startTime, this.endTime, this.elementValue});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      elementValue: List<ElementValue>.from(
          json['elementValue'].map((x) => ElementValue.fromJson(x))),
    );
  }
}

class ElementValue {
  String value;
  String measures;

  ElementValue({this.value, this.measures});

  factory ElementValue.fromJson(Map<String, dynamic> json) {
    return ElementValue(
      value: json['value'] ?? '',
      measures: json['measures'] ?? '',
    );
  }
}






// final users = await httpService.get('users', (json) {
//   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// });