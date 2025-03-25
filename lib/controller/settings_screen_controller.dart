import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/repositories/settings_repository.dart';

class SettingsScreenController extends GetxController {
  final SettingsRepository repository;
  SettingsScreenController({required this.repository});

  final _isLoading = false.obs;
  final _enabledRemindNotification = false.obs;
  bool get isLoading => _isLoading.value;
  bool get enabledRemindNotification => _enabledRemindNotification.value;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() async {
    try {
      _isLoading.value = true;
      _enabledRemindNotification.value =
          await repository.getEnableRemindNotification();
    } catch (e) {
      e.printError();
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void navigateToLicenseScreen() {
    Get.toNamed("/license");
  }

  Future<void> toggleRemindNotification(bool value) async {
    try {
      _isLoading.value = true;
      await repository.setEnableRemindNotification(value);
      _enabledRemindNotification.value = value;
    } catch (e) {
      e.printError();
    } finally {
      _isLoading.value = false;
      update();
    }
  }
}
