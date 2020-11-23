import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ridjnaelcrypt/ridjnaelcrypt.dart' as crypt;

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String defValue]) {
    return _prefsInstance.getString(key) == null ? null : crypt.Ridjnael.computeDecrypt(_prefsInstance.getString(key));
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs?.setString(key, crypt.Ridjnael.computeEncrypt(value)) ??
        Future.value(false);
  }

  static Future<bool> remove(String key) async {
    var prefs = await _instance;
    return prefs.remove(key) ?? Future.value(false);
  }
}
