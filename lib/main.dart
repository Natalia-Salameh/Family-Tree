import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');
  runApp(MyApp(initialRoute: token == null ? AppRoute.getStarted : AppRoute.home));
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
