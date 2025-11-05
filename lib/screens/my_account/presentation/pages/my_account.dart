import 'package:borsa_now_bis/screens/my_account/presentation/widgets/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/address.dart';
import '../widgets/bank_info.dart';
import '../widgets/password_page.dart';
import '../widgets/personal_identity.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: Opacity(
                      opacity: value,
                      child: Text(
                        "my_profile".tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              generalContainer(context,"personal_info".tr, "assets/icons/my_account.svg",(){
                Get.to(PersonalInfo());
              }),
              SizedBox(height: 10),
              generalContainer(context,"address".tr, "assets/icons/pin.svg",(){
                Get.to(Address());
              }),
              SizedBox(height: 10),
              generalContainer(context,"identity_info".tr, "assets/icons/badge.svg",(){
                Get.to(PersonalIdentity());
              }),
              SizedBox(height: 10),
              generalContainer(context,"bank_info".tr, "assets/icons/bank.svg",(){
                Get.to(BankInfo());
              }),
              SizedBox(height: 10),
              generalContainer(context,"password".tr, "assets/icons/key.svg",(){
                Get.to(PasswordPage());
              }),
              SizedBox(height: 20),
              pushUpAnimation(
                 InkWell(
                  onTap: (){
                    showLogoutAlert(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                    margin: EdgeInsets.symmetric( horizontal: 10),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white,
                      border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/logout.svg"),
                        SizedBox(width: 10),
                        Text("logout".tr,style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor.fromHex(AppTheme.primaryColor),
                        ),),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget generalContainer(BuildContext context,String title, String assets,GestureTapCallback onTap) {
    return bounceAnimation(
      c: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          margin: EdgeInsets.symmetric( horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: HexColor.fromHex("#CDCCE0")),
          ),
          child: Row(
            children: [
              SvgPicture.asset(assets),
              SizedBox(width: 20),
              Expanded(child: Text(title,style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),)),
              Icon(
                Icons.arrow_forward,
                color: HexColor.fromHex(AppTheme.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
      elevation: 0,
      leadingWidth: 120,
      leading: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: 0.5 + (value * 0.5),
              child: Hero(
                tag: "a2",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",
                  ),
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Hero(
                  tag: "a4",
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HexColor.fromHex(AppTheme.borderGrey),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Hero(
                  tag: "a3",
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HexColor.fromHex(AppTheme.borderGrey),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/notifications.svg",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
