import 'package:get/get.dart';
import 'package:introspection_note_mvp/controller/create_instropection_screen_controller.dart';

class CreateIntrospectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateInstropectionScreenController>(
      () => CreateInstropectionScreenController(repository: Get.find()),
    );
  }
}
