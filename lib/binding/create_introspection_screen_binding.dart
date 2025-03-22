import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/create_instropection_screen_controller.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';

class CreateIntrospectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteRepository>(() => NoteRepositoryImpl());
    Get.lazyPut<CreateInstropectionScreenController>(
      () => CreateInstropectionScreenController(repository: Get.find()),
    );
  }
}
