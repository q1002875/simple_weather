// import 'package:shared_preferences/shared_preferences.dart';

// class StorageService {
//    SharedPreferences _prefs;

//   // 初始化 SharedPreferences 對象
//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // 將數據儲存到 shared preferences 中
//   Future<void> saveData(String key, String value) async {
//     await _prefs.setString(key, value);
//   }

//   // 從 shared preferences 中讀取數據
//   Future<String> loadData(String key) async {
//     return _prefs.getString(key);
//   }
// }

// // final storage = StorageService();
// // await storage.init();

// // // 將數據儲存到 shared preferences 中
// // await storage.saveData('key', 'value');

// // // 從 shared preferences 中讀取數據
// // final data = await storage.loadData('key');
