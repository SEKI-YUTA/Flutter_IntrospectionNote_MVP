import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/settings_screen_controller.dart';

class SettingsPage extends GetView<SettingsScreenController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Text('設定')),
        body: SafeArea(
          child: Opacity(
            opacity: controller.isLoading ? 0.5 : 1,
            child: Column(
              children: [
                _buildRemindNotificationTile(),

                _buildRemindTimeTile(),
                const Spacer(),
                GestureDetector(
                  onTap: controller.navigateToLicenseScreen,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'ライセンス',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRemindTimeTile() {
    return ListTile(
      title: const Text('リマインドの時間'),
      trailing:
          controller.enabledRemindNotification
              ? GestureDetector(
                onTap: () {
                  controller.changeRemindTime();
                },
                child: Text(
                  controller.remindTime,
                  style: const TextStyle(fontSize: 16),
                ),
              )
              : null,
    );
  }

  Widget _buildRemindNotificationTile() {
    return ListTile(
      title: const Text('内省のリマインド'),
      subtitle:
          controller.grantedNotificationPermission &&
                  (controller.grantedExactAlarmPermission || Platform.isIOS)
              ? null
              : GestureDetector(
                onTap: () {
                  controller.requestExactNotificationPermission();
                },
                child: const Text(
                  '通知の許可が必要です',
                  style: TextStyle(color: Colors.red),
                ),
              ),
      trailing: Switch(
        value: controller.enabledRemindNotification,
        onChanged:
            controller.grantedNotificationPermission &&
                    (controller.grantedExactAlarmPermission || Platform.isIOS)
                ? (value) {
                  controller.toggleRemindNotification(value);
                }
                : null,
      ),
    );
  }
}
