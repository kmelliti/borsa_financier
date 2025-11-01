import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/review_list.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/widgets/single_item_shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/config/bottom_navigator.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../payment/presentation/pages/payment_page.dart';

class DetailsProductSheet extends StatelessWidget {
  DetailsProductSheet({super.key});

  final List<String> images = ["assets/icons/aa1.png", "assets/icons/a2.png"];
  final ValueNotifier<int> sliderIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: FloatingActionButton.extended(
          heroTag: "buy_now",
          onPressed: () {
            Get.to(PaymentMethodsPage());
          },
          backgroundColor: HexColor.fromHex(AppTheme.primaryColor),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(        // Custom shape
            borderRadius: BorderRadius.circular(30),
          ),
          label: Text("buy_now".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
          icon: null,

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "a1",
                  child: SizedBox(
                    height: 400,
                    child: PageView(
                      onPageChanged: (int currentIndex) {
                        sliderIndex.value = currentIndex;
                      },
                      children:
                          images.map((im) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#EFEFE3"),
                              ),
                              child: Center(child: Image.asset(im, height: 200)),
                            );
                          }).toList(),
                    ),
                  ),
                ),

                Positioned(
                  top: 60,
                  right: 20,
                  left: 20,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Hero(
                          tag: "a2",
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,

                              border: Border.all(
                                color: HexColor.fromHex(AppTheme.borderGrey),
                              ),
                            ),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Spacer(),
                      Hero(
                        tag: "a3",
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,

                            border: Border.all(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                          ),
                          child: SvgPicture.asset("assets/icons/share.svg"),
                        ),
                      ),
                      Hero(
                        tag: "a4",
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                          ),
                          child: SvgPicture.asset("assets/icons/like.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: ValueListenableBuilder(
                    valueListenable: sliderIndex,
                    builder: (context, index, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            images.map((im) {
                              return Container(
                                width: 10,
                                height: 10,
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                  color:
                                      images[index] == im
                                          ? HexColor.fromHex(
                                            AppTheme.primaryColor,
                                          )
                                          : HexColor.fromHex(
                                            AppTheme.secondaryColor,
                                          ),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "ماتشا كريم فرابوتشينو",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      getPriceInText(10.00),
                      SizedBox(width: 10),
                      getDiscountedPriceInText(20.00),
                      SizedBox(width: 10),

                      Hero(
                        tag: 'discount',
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: HexColor.fromHex("#2CB9A3"),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            "50%-",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ReadMoreText(
                    'مشروب بارد ومنعش يجمع بين نكهة الشاي الأخضر الياباني ماتشا والكريمة المخفوقة الغنية، ليمنحك لحظة استرخاء بطعم فريد. مثالي لعشاق النكهات مشروب بارد ومنعش يجمع بين نكهة الشاي الأخضر الياباني ماتشا والكريمة المخفوقة الغنية، ليمنحك لحظة استرخاء بطعم فريد. مثالي لعشاق النكهات ',
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    colorClickableText: Colors.pink,
                    trimCollapsedText: 'show_more'.tr,
                    trimExpandedText: 'show_less'.tr,
                    moreStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(

                        child: Hero(
                          tag: "min_quantity",
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //available_pcs
                                Text("min_quantity".tr,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: HexColor.fromHex(AppTheme.primaryColor),fontSize: 16
                                ),),
                                SizedBox(height: 10,),

                                Text("1000",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: HexColor.fromHex(AppTheme.primaryColor,),fontWeight: FontWeight.bold,fontSize: 16
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Hero(
                          tag: "available_pcs",
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                //available_pcs
                                Text("available_pcs".tr,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: HexColor.fromHex(AppTheme.primaryColor),fontSize: 16
                                ),),
                                SizedBox(height: 10,),
                                Text("1000",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: HexColor.fromHex(AppTheme.primaryColor,),fontWeight: FontWeight.bold,fontSize: 16
                                )),
                              ],

                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            ReviewList(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "you_may_like".tr,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 20,
                    color: HexColor.fromHex("#1E1D33"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            ListView.builder(
              padding: EdgeInsets.all(20),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (c,i){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: SingleItemShoppingList(),
                );
              },
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
