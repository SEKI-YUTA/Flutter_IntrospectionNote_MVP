import 'package:flutter/material.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: '内省ノート',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(Icons.note),
      applicationLegalese: 'All rights reserved',
    );
  }
}
