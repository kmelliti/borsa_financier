import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class WithdrawRequestPage extends StatelessWidget {
  const WithdrawRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF26255D); // dark navy color

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: Icon(
              Icons.arrow_back,
              color: HexColor.fromHex(AppTheme.primaryColor),
            ),
          ),
        ),
        title: Text(
          'request_withdraw'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // مبلغ الإدخال
              TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'أدخل المبلغ',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  // suffixIcon: SvgPicture.asset("assets/icons/sar.svg" ,height: 5,),
                  //  contentPadding:
                  //  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  //  border: OutlineInputBorder(
                  //    borderRadius: BorderRadius.circular(25),
                  //    borderSide: BorderSide(color: Colors.grey.shade300),
                  //  ),
                ).applyDefaults(Theme.of(context).inputDecorationTheme),
              ),

              const SizedBox(height: 20),

              // معلومات الحساب
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/bank.svg"),
                        SizedBox(width: 10),
                        Text(
                          "account_info".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'اسم البنك البنك الأهلي السعودي',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: primaryColor),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'رقم الآيبان SA4420000001234567891234',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // زر إضافة حساب
              InkWell(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(AppTheme.filledBox),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "add_new_bank".tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: HexColor.fromHex(AppTheme.primaryColor),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                          fontSize: 18,
                        ),
                      ),

                      Icon(
                        Icons.add,
                        color: HexColor.fromHex(AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // زر إرسال الطلب
              ElevatedButton(
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/validated_request.svg"),
                            SizedBox(height: 20,),
                            Text("request_sent".tr,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                              fontSize: 20,
                            ),),
                            Text("request_sent_body".tr,textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: HexColor.fromHex("#717088"),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                              fontSize: 20,
                            ),),
                            SizedBox(height: 60,),
                            ElevatedButton(onPressed: (){

                            }, child: Text("follow_requests".tr),style: AppTheme.outlinedButtonStyle,)
                          ],
                        ),
                      ),
                    ),
                  );
                },

                child: Text("send_request".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
