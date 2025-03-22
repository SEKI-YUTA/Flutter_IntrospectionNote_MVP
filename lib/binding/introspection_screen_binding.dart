import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/introspection_list_screen_controller.dart';
import 'package:introspection_note_mvp/data/repositories/note_repository.dart';

class IntrospectionListScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => IntrospectionListScreenController(repository: Get.find()),
    );
  }
}
