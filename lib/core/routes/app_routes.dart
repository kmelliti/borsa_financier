import 'package:borsa_now_bis/screens/login/presentation/pages/login_page.dart';
import 'package:borsa_now_bis/screens/main_screen/presentation/pages/main_screen.dart';
import 'package:borsa_now_bis/screens/sign_up/presentation/pages/sign_up.dart';
import 'package:borsa_now_bis/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../../reset_password/pages/reset_password.dart';

class AppRoutes {
  static const String splash = '/';
  static const String mainScreen = '/main';
  static const String signUp = '/sign-up';
  static const String resetPassword = '/reset-password';
  static const String login = '/login';

  static final routes = [
    GetPage(name: login, page: () =>  LoginPage()),
    GetPage(name: splash, page: () =>  SplashScreen()),
    GetPage(name: mainScreen, page: () =>  MainScreen()),
    GetPage(name: signUp, page: () =>  SignUp()),
    GetPage(name: resetPassword, page: () =>  ResetPassword()),
  ];
}
