import 'package:borsa_now_bis/screens/main_screen/presentation/pages/main_screen.dart';
import 'package:borsa_now_bis/screens/sign_up/widgets/bank_step.dart';
import 'package:borsa_now_bis/screens/sign_up/widgets/identity_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_theme.dart';
import '../../widgets/address_step.dart';
import '../../widgets/create_password_step.dart';
import '../../widgets/personal_information_step.dart';
import '../controller/sign_up_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;

  final SignUpController _signUpController = getIt();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 80,
        centerTitle: false,
        leading: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Opacity(
              opacity: value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: 0.5 + (value * 0.5),
                child: InkWell(
                  onTap: () {
                    _signUpController.showExitAlert(context);

                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        title: Text(
          'create_account'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [getStepName(context), getPageNumber()],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: (_currentPage + 1) / _totalPages,
              minHeight: 6,
              color: HexColor.fromHex(AppTheme.primaryColor),
              backgroundColor: HexColor.fromHex("#DEDDFF"),
              borderRadius: BorderRadius.circular(6),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  PersonalInformationStep(
                    onNextStep: () {
                      setState(() {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ),
                  AddressStep(onNextStep: () {
                    setState(() {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    });
                   }, onBackStep: () {
                    setState(() {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    });
                   },), // Placeholder for step 2
                  IdentityStep(
                    onNextStep: () {
                      setState(() {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    onBackStep: () {
                      setState(() {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ), // Placeholder for step 3
                  BankInfoStep(
                    onNextStep: () {
                      setState(() {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    onBackStep: () {
                      setState(() {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ), // Placeholder for step 4
                  CreatePasswordStep(
                    onNextStep: () {
                      Get.to(MainScreen());
                    },
                    onBackStep: () {
                      setState(() {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  ), // Placeholder for step 5
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text getStepName(BuildContext context) {
    return Text(
      'personal_information'.tr,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: HexColor.fromHex("#393942")),
    );
  }

  getPageNumber() {
    return Row(
      children: [
        Text(
         ( _currentPage +1 ).toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "/${_totalPages.toString()}",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: HexColor.fromHex("#DEDDFF")),
        ),
      ],
    );
  }
}
