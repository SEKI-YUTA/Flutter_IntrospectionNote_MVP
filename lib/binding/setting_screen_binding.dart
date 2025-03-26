// GetXでの利用方法の例（初期化部分）
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/settings_screen_controller.dart';
import 'package:introspection_note_mvp/data/repositories/settings_repository.dart';
import 'package:introspection_note_mvp/data/sharedpref/SharedPreferenceHelper.dart';
import 'package:introspection_note_mvp/util/notification_util.dart';

class SettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedpreferenceHelper>(() => SharedpreferenceHelper.instance);

    Get.lazyPut<SettingsRepository>(
      () => SettingsRepository(sharedpreferencehelper: Get.find()),
    );

    Get.lazyPut<NotificationUtil>(() => NotificationUtil.instance);

    Get.lazyPut(() => SettingsScreenController(repository: Get.find(), notificationUtil: Get.find()));
  }
}
