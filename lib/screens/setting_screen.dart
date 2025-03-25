import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:introspection_note_mvp/controller/settings_screen_controller.dart';

class SettingScreen extends GetView<SettingsScreenController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Text("設定")),
        body: Opacity(
          opacity: controller.isLoading ? 0.5 : 1,
          child: Column(
            children: [
              ListTile(
                title: const Text("内省のリマインド"),
                trailing: Switch(
                  value: controller.enabledRemindNotification,
                  onChanged: (value) {
                    controller.toggleRemindNotification(value);
                  },
                ),
              ),
              Spacer(),
              GestureDetector(
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
                onTap: () {
                  Get.toNamed("/license");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
