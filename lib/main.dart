import 'package:family_tree_application/Locale/locale.dart';
import 'package:family_tree_application/controller/home_page_controller.dart';

import 'package:family_tree_application/controller/progress_bar.dart';
import 'package:family_tree_application/controller/signup_controller.dart';
import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/core/constants/theme.dart';
import 'package:family_tree_application/core/functions/network_handler.dart';
import 'package:family_tree_application/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(HomeController(), permanent: true);
  Get.put(ProgressController());
  Get.put(SignUpController());
  WidgetsFlutterBinding.ensureInitialized();
  DateTime? expiration = await NetworkHandler.getExpirationDate();
  String? token = await NetworkHandler.getToken();
  Get.put(SignUpController());
  runApp(
    MyApp(
        initialRoute: (token == null ||
                expiration == null ||
                expiration.isBefore(DateTime.now()))
            ? AppRoute.splash
            : AppRoute.home),
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
      locale: Get.deviceLocale,
      translations: MyLocale(),
      theme: AppTheme.lightTheme,
    );
  }
}
