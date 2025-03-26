import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/settings_screen_controller.dart';

class SettingsPage extends GetView<SettingsScreenController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Text("設定")),
        body: SafeArea(
          child: Opacity(
            opacity: controller.isLoading ? 0.5 : 1,
            child: Column(
              children: [
                ListTile(
                  title: const Text("内省のリマインド"),
                  subtitle:
                      controller.grantedNotificationPermission &&
                              controller.grantedExactAlarmPermission
                          ? null
                          : GestureDetector(
                            onTap: () {
                              controller.requestExactNotificationPermission();
                            },
                            child: const Text(
                              "通知の許可が必要です",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                  trailing: Switch(
                    value: controller.enabledRemindNotification,
                    onChanged:
                        controller.grantedNotificationPermission &&
                                controller.grantedExactAlarmPermission
                            ? (value) {
                              controller.toggleRemindNotification(value);
                            }
                            : null,
                  ),
                ),

                Spacer(),
                GestureDetector(
                  onTap: controller.navigateToLicenseScreen,
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "ライセンス",
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
}
