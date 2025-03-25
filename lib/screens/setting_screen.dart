import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("設定")),
      body: Column(
        children: [
          ListTile(
            title: const Text("内省のリマインド"),
            trailing: Switch(value: false, onChanged: (value) {}),
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
    );
  }
}
