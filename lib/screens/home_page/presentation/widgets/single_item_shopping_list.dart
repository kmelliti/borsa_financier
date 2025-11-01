import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/details_product_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../payment/presentation/pages/checkout.dart';

class SingleItemShoppingList extends StatelessWidget {
  const SingleItemShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(context),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ماتشا كريم فرابوتشينو",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    getPriceInText(10.00),
                    SizedBox(width: 10),
                    getDiscountedPriceInText(20.00),
                  ],
                ),
                SizedBox(height: 10),
                Hero(
                  tag: "available_pcs",
                  child: Row(
                    children: [
                      Text(
                        "available_pcs".tr,
                        style: GoogleFonts.cairo(
                          color: HexColor.fromHex("#1E1D33"),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "1000",
                        style: TextStyle(
                          color: HexColor.fromHex("#5E5D68"),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                Hero(
                  tag: "min_quantity",
                  child: Row(
                    children: [
                      Text(
                        "min_quantity".tr,
                        style: GoogleFonts.cairo(
                          color: HexColor.fromHex("#1E1D33"),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),

                      Text(
                        "1000",
                        style: TextStyle(
                          color: HexColor.fromHex("#5E5D68"),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(DetailsProductSheet());
                        },
                        child: Text("details".tr),
                        style: AppTheme.outlinedButtonStyle,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Hero(
                        tag: "buy_now",
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(Checkout());
                          },
                          child: Text("buy_now".tr),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack header(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "a1",

          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#EFEFE3"),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Image.asset("assets/icons/aa1.png", height: 200),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Hero(
            tag: "discount",
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: HexColor.fromHex("#2CB9A3"),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Text(
                "50%-",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: StarRating(rating: 4, color: HexColor.fromHex("#fcc120")),
          ),
        ),
      ],
    );
  }
}
