import 'package:family_tree_application/core/constants/routes.dart';
import 'package:family_tree_application/view/screens/Forms/marriage_form.dart';
import 'package:family_tree_application/view/screens/Forms/spouse_form.dart';
import 'package:family_tree_application/view/screens/Forms/user_form.dart';
import 'package:family_tree_application/view/screens/Legacy/member_legacy.dart';

import 'package:family_tree_application/view/screens/Legacy/settings.dart';
import 'package:family_tree_application/view/screens/Legacy/update_legacy.dart';
import 'package:family_tree_application/view/screens/Legacy/user_legacy.dart';
import 'package:family_tree_application/view/screens/auth/get_started.dart';
import 'package:family_tree_application/view/screens/auth/login.dart';
import 'package:family_tree_application/view/screens/auth/signup.dart';
import 'package:family_tree_application/view/screens/auth/signup_verify_code.dart';
import 'package:family_tree_application/view/screens/home/home.dart';
import 'package:family_tree_application/view/screens/home/add_tree.dart';
import 'package:family_tree_application/view/screens/onBoarding/on_boarding1.dart';
import 'package:family_tree_application/view/screens/onBoarding/on_boarding2.dart';
import 'package:family_tree_application/view/screens/onBoarding/on_boarding3.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/Tree.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/add_member.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/diary.dart';
import 'package:family_tree_application/view/screens/onBoardingForm/member_form.dart';
import 'package:family_tree_application/view/screens/splash_screen.dart';
import 'package:get/get.dart';

import 'view/screens/onBoarding/onBoardingNav.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.splash, page: () => const SplashScreen()),
  GetPage(name: AppRoute.onBoardingNav, page: () => const OnBoardingWrapper()),
  GetPage(name: AppRoute.onBoarding1, page: () => const OnBoarding1()),
  GetPage(name: AppRoute.onBoarding2, page: () => const OnBoarding2()),
  GetPage(name: AppRoute.onBoarding3, page: () => const OnBoarding3()),
  GetPage(name: AppRoute.getStarted, page: () => const GetStarted()),
  GetPage(name: AppRoute.login, page: () => Login()),
  GetPage(name: AppRoute.signUp, page: () => SignUp()),
  GetPage(name: AppRoute.verifyCode, page: () => VerifyCode()),
  GetPage(name: AppRoute.home, page: () => const Home()),
  GetPage(name: AppRoute.userForm, page: () => UserForm()),
  GetPage(name: AppRoute.editLegacy, page: () => EditLegacy()),
  GetPage(name: AppRoute.legacy, page: () => Legacy()),
  GetPage(name: AppRoute.memberForm, page: () => MemberForm()),
  GetPage(name: AppRoute.tree, page: () => AddTree()),
  GetPage(name: AppRoute.treeForm, page: () => const TreeState()),
  GetPage(name: AppRoute.diary, page: () => const Diary()),
  GetPage(name: AppRoute.settings, page: () => const Settings()),
  GetPage(name: AppRoute.userLegacy, page: () => UserLegacy()),
  GetPage(
      name: AppRoute.spouseMarriageStatus, page: () => SpouseMarriageStatus()),
  GetPage(name: AppRoute.spouseForm, page: () => SpouseForm(role: '',)),
];
