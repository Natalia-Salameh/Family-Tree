import 'package:family_tree_application/controller/get_vote_controller.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/model/add_update_vote_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddVoteController extends GetxController {
  TextEditingController memberIdController = TextEditingController();
  TextEditingController voteController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  GetVoteController getVoteController = Get.put(GetVoteController());

  addVote() async {
    AddUpdateVoteModel addUpdateVoteModel = AddUpdateVoteModel(
      memberId: memberIdController.text,
      vote: voteController.text,
      reason: reasonController.text,
    );

    var response = await NetworkHandler.postRequest(
      AppLink.addUpdateVote,
      addUpdateVoteModel.toJson(),
      includeToken: true,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      getVoteController.memberId = memberIdController.text;
      getVoteController.getVote();
      print(response.body);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: response.body,
      );
      print(response.body);
    }
  }
}
