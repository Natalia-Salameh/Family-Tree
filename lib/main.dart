import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(ProgressController());
  WidgetsFlutterBinding.ensureInitialized();
  DateTime? expiration = await NetworkHandler.getExpirationDate();

  runApp(
    // MyApp(
    //   initialRoute: (expiration!.isBefore(DateTime.now()))
    //       ? AppRoute.getStarted
    //       : AppRoute.home,
    // ),
    MyApp(
      initialRoute: AppRoute.memberForm,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: routes,
    );
  }
}
