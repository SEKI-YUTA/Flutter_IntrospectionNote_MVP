import 'package:introspection_note_mvp/data/sharedpref/shared_preference_helper.dart';

class SettingsRepository {
  final SharedpreferenceHelper sharedpreferencehelper;
  SettingsRepository({required this.sharedpreferencehelper});

  Future<bool> getEnableRemindNotification() async {
    return await sharedpreferencehelper.getBool(
      SharedpreferenceHelper.SETTING_ENABLE_REMIND_NOTIFICATION,
    );
  }

  Future<bool> setEnableRemindNotification(bool value) async {
    return await sharedpreferencehelper.setBool(
      SharedpreferenceHelper.SETTING_ENABLE_REMIND_NOTIFICATION,
      value,
    );
  }
}
