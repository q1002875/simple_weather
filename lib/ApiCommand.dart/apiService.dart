import 'package:simple_weahter/ExtensionToolClass/HttpServer/Httpserver.dart';
import '../Cloud/Cloud.dart';

//ignore: camel_case_types
class apiService {
  final authkey = 'CWB-95C4A955-4E38-4B86-92B4-2F1E71669956';

  Future<WeatherData> getCountryData(String country) async {
    final today = HttpService(
        baseUrl:
            'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=$authkey&limit=7&format=JSON&locationName=$country&elementName=&sort=time');
    final response = await today.getJson();
    return WeatherData.fromJson(response as Map<String, dynamic>);
  }

  Future<WeatherWeekData> getWeekCountryData(String country) async {

    final weekWeatherData = HttpService(
        baseUrl:
            'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-091?Authorization=$authkey&format=JSON&locationName=$country&elementName=Wx');

    final response = await weekWeatherData.getJson();
    return WeatherWeekData.fromJson(response as Map<String, dynamic>);
  }
}









// final users = await httpService.get('users', (json) {
//   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// });