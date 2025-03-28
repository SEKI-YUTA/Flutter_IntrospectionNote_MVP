import 'package:flutter/material.dart';

class LicenseListPage extends StatelessWidget {
  const LicenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LicensePage(
      applicationName: '内省ノート',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(Icons.note), // アプリのアイコン
      applicationLegalese: 'All rights reserved',
    );
  }
}
