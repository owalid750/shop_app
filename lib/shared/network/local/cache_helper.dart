import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    String? key,
    bool? value,
  }) async {
    return await sharedPreferences!.setBool(key!, value!);
  }

  // static bool? getData({
  //   String? key,
  // }) {
  //   return sharedPreferences?.getBool(key!);
  // }

  static Future<bool?>? saveDate({
    String? key,
    dynamic value,
  }) async {
    if (value is String) await sharedPreferences?.setString(key!, value);
    if (value is int) await sharedPreferences?.setInt(key!, value);
    if (value is bool) await sharedPreferences?.setBool(key!, value);
    if (value is double) await sharedPreferences?.setDouble(key!, value);
    return null;
  }

  static dynamic getData({
    String? key,
  }) {
    return sharedPreferences?.get(key!);
  }

  static Future<bool?>? removeData({String? key}) async {
    return await sharedPreferences?.remove(key!);
  }
}
