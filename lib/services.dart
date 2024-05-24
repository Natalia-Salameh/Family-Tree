import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ApprovalService extends GetxService {
  final GetStorage storage = GetStorage();
  final String approvalKey = 'approvalMap';

  Map<String, String> get approvalMap => storage.read(approvalKey);

  void saveApproval(String nodeId, String status) {
    Map<String, String> currentMap = approvalMap;
    currentMap[nodeId] = status;
    storage.write(approvalKey, currentMap);
  }

  @override
  void onInit() {
    super.onInit();
    if (storage.read(approvalKey) == null) {
      storage.write(approvalKey, {});
    }
  }
}

final ApprovalService approvalService = Get.put(ApprovalService());
