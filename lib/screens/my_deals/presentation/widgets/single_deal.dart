import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_color_builder/image_color_builder.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/subscribed_deal_model.dart';

class SingleMyDeal extends StatelessWidget {
  const SingleMyDeal({super.key, required this.deal});

  final SubscribedDealModel deal;

  @override
  Widget build(BuildContext context) {
    return singleDeal(context);
  }

  Widget singleDeal(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGreyLight)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: ImageColorBuilder(
              //     url:
              //         "${baseUrlImage}/${deal.deal.product.productPictures.first.picture}",
              //     placeholder: (c, s) {
              //       return Container(
              //         height: 100,
              //         width: 100,
              //         decoration: BoxDecoration(
              //           color: HexColor.fromHex("#F4F4F4"),
              //           borderRadius: BorderRadius.circular(20),
              //           border: Border.all(
              //             color: HexColor.fromHex(AppTheme.borderGrey),
              //           ),
              //         ),
              //       );
              //     },
              //     builder: (c, image, color) {
              //       return Container(
              //         height: 100,
              //         width: 100,
              //
              //         decoration: BoxDecoration(
              //           color: color,
              //           borderRadius: BorderRadius.circular(20),
              //           border: Border.all(color: HexColor.fromHex("#F4F4F4")),
              //         ),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(20),
              //
              //           child: Center(child: image),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
               //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                   // color: HexColor.fromHex("#EFEFE3"),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network("${baseUrlImage}/${deal.deal.product.productPictures.first.picture}", ))),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.deal.product.name,
                        maxLines: 1,

                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
                          color: HexColor.fromHex(AppTheme.primaryColor),
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(height: 10),
                      Text(df.format(deal.createdAt)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#F5F5F5"),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "price".tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                getPriceInText(
                  double.parse(deal.deal.retailPrice),
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                  ),
                  12,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "bought_quantity".tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  deal.quantityPurchased.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#F5F5F5"),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "sold_quantity".tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  deal.deal.quantitySold.toString(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                // getPriceInText(
                //   10,
                //   Theme.of(context).textTheme.bodyMedium?.copyWith(
                //     color: HexColor.fromHex(AppTheme.primaryColor),
                //   ),
                //   12,
                // ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "available_in_storage".tr,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${deal.deal.quantity} ${"unit_in_storage".tr}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: HexColor.fromHex("#F5F5F5"),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "income".tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                getPriceInText(
                  double.parse(deal.actualProfit),
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: HexColor.fromHex(AppTheme.primaryColor),
                  ),
                  12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
