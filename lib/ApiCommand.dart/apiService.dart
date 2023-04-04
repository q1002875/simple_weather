
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_weahter/HttpServer/Httpserver.dart';

import '../Cloud/Cloud.dart';
import '../HttpServer/HttpServerModel.dart';


//ignore: camel_case_types
class apiService{

final authkey = 'CWB-95C4A955-4E38-4B86-92B4-2F1E71669956';
Future<WeatherData> getCountryData(String country) async {
 //final other = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-95C4A955-4E38-4B86-92B4-2F1E71669956&limit=7&format=JSON&locationName=%E6%96%B0%E7%AB%B9%E7%B8%A3&elementName=&sort=time"; 
 final httpService = HttpService(baseUrl:'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=$authkey&limit=7&format=JSON&locationName=$country&elementName=&sort=time' );
// final httpService = HttpService(baseUrl:httpUrlString );
 final response = await httpService.getJson();
 print('json$json');
  return WeatherData.fromJson(response as Map<String, dynamic>);

// final users = await httpService.get('users', (json) {
//   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// });
}





  
}