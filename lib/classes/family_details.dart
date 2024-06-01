import 'package:family_tree_application/classes/featured_fam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:family_tree_application/core/constants/colors.dart';

class FamilyDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FeaturedFamily family = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(family.familyName, style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.myCustomColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  family.crestImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                family.familyName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                family.details,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
