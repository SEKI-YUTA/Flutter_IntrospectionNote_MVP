import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/introspection_list_screen_controller.dart';

class IntrospectionListScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => IntrospectionListScreenController(repository: Get.find()),
    );
  }
}
