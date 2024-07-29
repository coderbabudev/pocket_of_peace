// import 'package:shared_preferences/shared_preferences.dart';
//
// class PreferenceUtils {
//   static Future<SharedPreferences> get _instance async =>
//       _prefsInstance = await SharedPreferences.getInstance();
//   static late SharedPreferences _prefsInstance;
//
//   static Future<SharedPreferences> init() async {
//     _prefsInstance = await _instance;
//     return _prefsInstance;
//   }
//
//   static String getYesNoBtnValue(String key) {
//     return _prefsInstance.getString(key) ?? '';
//   }
//
//   static Future<bool> setYesNoBtnValue(String key, String value) async {
//     var prefs = await _instance;
//     return prefs.setString(key, value);
//   }
//
//   static Future<bool> clearAllPreferences() async {
//     var prefs = await _instance;
//     return prefs.clear();
//   }
// }
