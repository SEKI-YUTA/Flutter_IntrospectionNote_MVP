import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceHelper {
  static const String SETTING_ENABLE_REMIND_NOTIFICATION =
      "introspection_note_mvp:setting_enable_remind_notification";
  static final String SETTING_PUSH_NOTIFICATION_ID =
      "introspection_note_mvp:setting_push_notification_id";
  // 10:10のように文字列で保存しておく
  static final String SETTING_PUSH_NOTIFICATION_TIME =
      "introspection_note_mvp:setting_push_notification_time";

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
    return await prefs.setBool(key, value);
  }

  Future<int> getInt(String key) async {
    final prefs = await instance.prefs;
    return prefs.getInt(key) ?? 0;
  }

  Future<bool> setInt(String key, int value) async {
    final prefs = await instance.prefs;
    return await prefs.setInt(key, value);
  }

  Future<String> getString(String key) async {
    final prefs = await instance.prefs;
    return prefs.getString(key) ?? "";
  }

  Future<bool> setString(String key, String value) async {
    final prefs = await instance.prefs;
    return await prefs.setString(key, value);
  }
}
