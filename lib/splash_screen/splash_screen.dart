import 'dart:developer';
import 'dart:ffi';

import 'package:borsa_now_bis/core/routes/app_routes.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/pages/home_page.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/pages/my_account.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/widgets/bank_info.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/widgets/password_page.dart';
import 'package:borsa_now_bis/screens/my_wallet/presentation/widgets/fund_request.dart';
import 'package:borsa_now_bis/screens/payment/presentation/pages/checkout.dart';
import 'package:borsa_now_bis/screens/payment/presentation/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:borsa_now_bis/core/di/di.dart';

import '../core/config/app_constants.dart';
import '../core/services/app_service.dart';
import '../screens/login/presentation/pages/login_page.dart';
import '../screens/main_screen/presentation/pages/main_screen.dart';
import '../screens/my_account/presentation/widgets/address.dart';
import '../screens/my_account/presentation/widgets/personal_identity.dart';
import '../screens/my_account/presentation/widgets/personal_info.dart';
import '../screens/my_wallet/presentation/widgets/request_withdraw.dart';
import '../reset_password/pages/reset_password.dart';
import '../screens/sign_up/presentation/pages/sign_up.dart';
import '../screens/sign_up/widgets/personal_information_step.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppServices appServices = getIt();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      appServices.getCities();
      appServices.getBanks();
    } catch (e, s) {
      log("$e , $s");
    }
    log("Prentable token ${appServices.getToken()}");

    bool isLoggedIn = appServices.getToken() != null;
    Future.delayed(Duration(seconds: 4), () {
      if (isLoggedIn) {
        WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
          Get.offNamed(AppRoutes.mainScreen);
        });
      } else {
        WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
          Get.offNamed(AppRoutes.login);
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/0484aab0c5a24014f17a6bf62f729f73711ad0ed.gif",
          height: 500,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//git@github.com-giga:kmelliti/starter.git
