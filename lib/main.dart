import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:introspection_note_mvp/binding/application_binding.dart';
import 'package:introspection_note_mvp/binding/create_introspection_screen_binding.dart';
import 'package:introspection_note_mvp/binding/introspection_screen_binding.dart';
import 'package:introspection_note_mvp/binding/setting_screen_binding.dart';
import 'package:introspection_note_mvp/data/db/DatabaseHelper.dart';
import 'package:introspection_note_mvp/screens/create_introspection_screen.dart';
import 'package:introspection_note_mvp/screens/introspection_list_screen.dart';
import 'package:introspection_note_mvp/screens/license_screen.dart';
import 'package:introspection_note_mvp/screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ja_JP');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "内省ノート",
      initialRoute: "/introspection_list",
      initialBinding: ApplicationBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0F766E)),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0F766E),
          brightness: Brightness.dark,
        ),
      ),
      getPages: [
        GetPage(
          name: "/introspection_list",
          page: () => IntrospectionListPage(),
          binding: IntrospectionListScreenBinding(),
        ),
        GetPage(
          name: "/create_introspection",
          page: () => CreateIntrospectionPage(),
          binding: CreateIntrospectionBinding(),
        ),
        GetPage(
          name: "/settings",
          page: () => SettingsPage(),
          binding: SettingScreenBinding(),
        ),
        GetPage(name: "/license", page: () => const LicenseListPage()),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ja', 'JP'), // Japanese
      ],
    );
  }
}

class AppLifecycleService extends GetxService with WidgetsBindingObserver {
  final DatabaseHelper dbHelper = Get.find<DatabaseHelper>();
  @override
  void onInit() {
    super.onInit();
    print("AppLifecycleService onInit");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    print("AppLifecycleService onClose");
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("state: $state");
    if (state == AppLifecycleState.detached) {
      dbHelper.close();
    } else if (state == AppLifecycleState.resumed) {
      await dbHelper.open();
    }
  }
}
