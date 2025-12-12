import 'package:borsa_now_bis/core/services/home_page_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/deal_product_model.dart';
import '../../data/models/review_response_model.dart';

class HomePageController {

  final HomePageService _homePageService;

  HomePageController(this._homePageService);

  Future<List<DealProductModel>> getDealProducts(int pageKey, Map<String, dynamic>? value) async {
    return await _homePageService.getDealProducts(pageKey,value);
  }
  Future<List<DealProductModel>> getRelatedDeals(int dealId) async {
    return await _homePageService.getRelatedDeals(dealId);
  }

  Future<ReviewResponseModel> getReviews(String productId) async {
    return await _homePageService.getReviews(productId);
  }
  Future<ReviewModel> addReview (List<String?> images , Map<String,dynamic> params) async {
    return await _homePageService.addReview(images, params);
  }
  Future<void> addDeleteFav ( Map<String,dynamic> params) async {
    return await _homePageService.addDeleteFav( params);
  }

  Future<void> subscribedToDeal (Map<String,dynamic> params)async {
    return await _homePageService.subscribedToDeal(params);
  }

  void showSuccessSubscribeDeal(BuildContext context) {

    Get.dialog(
      barrierDismissible: false,
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
              SvgPicture.asset("assets/icons/success_card.svg"),
              SizedBox(height: 20),

              Text(
                "payment_success".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex("#1E1D33"),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "payment_success_sub".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex("#717088"),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {


                  Get.offAllNamed(AppRoutes.mainScreen,arguments: 2);


                },
                child: Text("my_deals".tr),

              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                  Get.back();
                  Get.offAllNamed(AppRoutes.mainScreen);

                },
                child: Text("mass_shopping".tr),
                style: AppTheme.outlinedButtonStyle,
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}