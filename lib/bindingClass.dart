import 'package:get/get.dart';
import 'package:family_tree_application/controller/user_form_controller.dart';

class UserFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserFormController>(() => UserFormController());
  }
}
