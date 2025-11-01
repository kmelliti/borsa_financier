import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';

import '../../../../reset_password/pages/reset_password.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              SvgPicture.asset("assets/icons/logo.svg",height: 90,fit: BoxFit.cover,),
              SizedBox(height: 60,),
              Text("login".tr,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                child: TextField(      decoration: InputDecoration(
                    hintText: "username".tr
                ).applyDefaults(Theme.of(context).inputDecorationTheme),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),

                child: TextField(
                  decoration: InputDecoration(
                   hintText: "password".tr
                  ).applyDefaults(Theme.of(context).inputDecorationTheme),
                ),
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      Get.to(()=>ResetPassword());
                    },
                    child: Text("forgot_password".tr,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                  SizedBox(width: 20,),
                ],
              ),

              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(onPressed: (){}, child: Text("login".tr)),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(onPressed: (){},style: AppTheme.outlinedButtonStyle, child: Text("create_account".tr),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
