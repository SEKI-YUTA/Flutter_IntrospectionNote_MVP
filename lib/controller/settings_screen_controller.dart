import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/repositories/settings_repository.dart';
import 'package:introspection_note_mvp/util/notification_util.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreenController extends GetxController
    with WidgetsBindingObserver {
  final SettingsRepository repository;
  final NotificationUtil notificationUtil;
  SettingsScreenController({
    required this.repository,
    required this.notificationUtil,
  });

  final _isLoading = false.obs;
  final _grantedNotificationPermission = false.obs;
  final _grantedExactAlarmPermission = false.obs;
  final _enabledRemindNotification = false.obs;
  bool get isLoading => _isLoading.value;
  bool get grantedNotificationPermission =>
      _grantedNotificationPermission.value;
  bool get enabledRemindNotification => _enabledRemindNotification.value;
  bool get grantedExactAlarmPermission => _grantedExactAlarmPermission.value;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void _initializeData() async {
    try {
      _isLoading.value = true;
      _enabledRemindNotification.value =
          await repository.getEnableRemindNotification();
      _grantedNotificationPermission.value =
          await Permission.notification.status == PermissionStatus.granted;
      _grantedExactAlarmPermission.value =
          await Permission.scheduleExactAlarm.status ==
          PermissionStatus.granted;
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
      if (value) {
        NotificationUtil.instance.enableRemindNotification();
        Get.snackbar("設定", "リマインド通知を有効にしました");
      } else {
        NotificationUtil.instance.disableRemindNotification();
        Get.snackbar("設定", "リマインド通知を無効にしました");
      }
    } catch (e) {
      e.printError();
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  Future<void> requestExactNotificationPermission() async {
    var notification = await Permission.notification.request();
    var exactAlarm = await Permission.scheduleExactAlarm.request();
    _grantedNotificationPermission.value = notification == PermissionStatus.granted;
    _grantedExactAlarmPermission.value = exactAlarm == PermissionStatus.granted;
    update();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _initializeData();
    }
  }
}
