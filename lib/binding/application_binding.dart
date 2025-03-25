// GetXでの利用方法の例（初期化部分）
import 'package:get/get.dart';
import 'package:introspection_note_mvp/data/db/DatabaseHelper.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';
import 'package:introspection_note_mvp/main.dart';

class ApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DatabaseHelper>(DatabaseHelper.instance, permanent: true);

    Get.put<NoteRepository>(
      NoteRepositoryImpl(dbHelper: Get.find<DatabaseHelper>()),
      permanent: true,
    );

    // Get.put<NoteRepository>(NoteRepositoryFakeImpl(), permanent: true);

    Get.put(AppLifecycleService(), permanent: true);
  }
}
