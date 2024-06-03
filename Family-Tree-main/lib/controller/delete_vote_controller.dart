import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/core/constants/linkapi.dart';

class DeleteVoteController extends GetxController {
  var voteId = '';

  deleteVote() async {
    var response = await NetworkHandler.postParamsRequest(
      AppLink.deleteVote,
      includeToken: true,
      queryParams: {'voteId': voteId},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
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
