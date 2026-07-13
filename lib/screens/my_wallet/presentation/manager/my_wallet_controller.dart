import 'package:borsa_now_bis/core/models/my_request_fund_model.dart';
import 'package:borsa_now_bis/core/routes/app_routes.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/models/chart_sales_model.dart';
import '../../../../core/models/funding_entity_model.dart';
import '../../../../core/services/my_wallet_services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class MyWalletController {
  final MyWalletServices myWalletServices;

  MyWalletController({required this.myWalletServices});

  Future<Map<String, dynamic>> getMyWalletDashboard() async {
    return myWalletServices.getMyWalletDashboard();
  }
  Future<void> withdrawRequest(Map<String,dynamic> params )async {
    return myWalletServices.withdrawRequest(params);
  }
  Future<void> addFundRequest(Map<String,dynamic> params )async {
    return myWalletServices.addFundRequest(params);
  }

  Future<List<ChartSalesModel>> getStats(String year, String month) async {
    return myWalletServices.getStats(year, month);
  }
  Future<List<FundingEntityModel>> getFundingEntities() async {
    return myWalletServices.getFundingEntities();
  }
  Future<List<MyRequestFundModel>> getMyFundRequests(int page) async {
    return myWalletServices.getMyFundRequests(page);
  }


  void showSuccessWithdrawRequest(BuildContext context) {
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
              Text("request_sent".tr,style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
                fontSize: 20,
              ),),
              Text("request_sent_body".tr,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: HexColor.fromHex("#717088"),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                fontSize: 16,
              ),),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){

                Get.offNamed(AppRoutes.mainScreen,arguments: 1);




              }, child: Text("follow_requests".tr),style: AppTheme.outlinedButtonStyle,)
            ],
          ),
        ),
      ),
    );
  }

  void showErrorWithdrawRequest(BuildContext context, String? error) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/error.svg"),
              SizedBox(height: 20),
              Text(
                "error_title".tr,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: HexColor.fromHex("#1E1D33"),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                  fontSize: 20,
                ),
              ),
              Text(
                error ?? "error_body2".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex("#717088"),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("ok".tr,style:Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  fontSize: 14,
                ),),
                style: AppTheme.outlinedButtonStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
