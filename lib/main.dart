import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:introspection_note_mvp/binding/create_introspection_screen_binding.dart';
import 'package:introspection_note_mvp/binding/introspection_screen_binding.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';
import 'package:introspection_note_mvp/screens/create_introspection_screen.dart';
import 'package:introspection_note_mvp/screens/introspection_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ja_JP');
  Get.put<NoteRepository>(NoteRepositoryImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "内省ノート",
      initialRoute: "/introspection_list",
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
      ],
    );
  }
}
