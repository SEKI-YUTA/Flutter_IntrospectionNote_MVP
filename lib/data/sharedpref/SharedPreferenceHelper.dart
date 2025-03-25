import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceHelper {
  static const String SETTING_ENABLE_REMIND_NOTIFICATION =
      "introspection_note_mvp:setting_enable_remind_notification";

  SharedpreferenceHelper._privateConstructor();
  static final SharedpreferenceHelper instance =
      SharedpreferenceHelper._privateConstructor();

  Future<SharedPreferences> get prefs async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> getBool(String key) async {
    final prefs = await instance.prefs;
    return prefs.getBool(key) ?? false;
  }

  Future<bool> setBool(String key, bool value) async {
    final prefs = await instance.prefs;
    return prefs.setBool(key, value);
  }
}
