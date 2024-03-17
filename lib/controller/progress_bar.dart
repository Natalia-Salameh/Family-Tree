import 'package:get/get.dart';

class ProgressController extends GetxController {
  RxDouble progress = 0.0.obs;

  void updateProgress() {
    progress.value += 0.5;
  }
}
