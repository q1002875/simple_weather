// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class HttpService {
//   final String baseUrl;
//   final http.Client client;

//   HttpService({ this.baseUrl, this.client});

//   Future<T> get<T>( T Function(dynamic json) fromJson) async {
//     final response = await client.get(Uri.parse('$baseUrl'));

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       final data = fromJson(json);
//       return data;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<T> post<T>( dynamic body, T Function(dynamic json) fromJson) async {
//     final response = await client.post(
//       Uri.parse('$baseUrl'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(body),
//     );

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       final data = fromJson(json);
//       return data;
//     } else {
//       throw Exception('Failed to post data');
//     }
//   }
// }



// //展示
// // final httpService = HttpService(
// //   baseUrl: 'https://example.com/api',
// //   client: http.Client(),
// // );

// // final users = await httpService.get('users', (json) {
// //   return List<User>.from(json.map((userJson) => User.fromJson(userJson)));
// // });
