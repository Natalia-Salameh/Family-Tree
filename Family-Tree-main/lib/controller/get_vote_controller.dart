import 'package:family_tree_application/model/get_vote_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class GetVoteController extends GetxController {
  var id = '';
  var memberId = '';
  var vote = '';
  var reason = '';

  getVote() async {
    var response = await NetworkHandler.getRequest(
      AppLink.getVote,
      includeToken: true,
      queryParams: {'memberId': memberId},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      GetVoteModel getVoteModel = getVoteModelFromJson(response.body);
      id = getVoteModel.id;
      memberId = getVoteModel.memberId;
      vote = getVoteModel.vote;
      reason = getVoteModel.reason;
      print(response.body);
    } else {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text(response.body),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
