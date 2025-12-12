import 'dart:math';

import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home_page/data/models/deal_product_model.dart';

class PaymentMethodsPage extends StatefulWidget {
  final DealProductModel dealModel;
  final double? amountInvested;
  final int? couponCode;

  const PaymentMethodsPage({
    super.key,
    required this.dealModel,
    this.amountInvested,
    this.couponCode,
  });

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  int selectedMethod = -1;

  final HomePageController homePageController = getIt();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final paymentMethods = [
    {'label': 'Apple Pay', 'logo': 'assets/apple_pay.png', 'size': "100"},
    {'label': 'Samsung Pay', 'logo': 'assets/samsung_pay.png', 'size': "100"},
    {'label': 'Google Pay', 'logo': 'assets/google_pay.png', 'size': "50"},
    {'label': 'Borsa Now', 'logo': 'assets/borsa_now_pay.png', 'size': "50"},
    {'label': 'pay_card'.tr, 'logo': 'assets/card.png', 'size': "50"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
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
                    Get.back();
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
          'payment'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListView.separated(
              itemCount: paymentMethods.length,
              shrinkWrap: true,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                final selected = selectedMethod == index;

                return GestureDetector(
                  onTap: () => setState(() => selectedMethod = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color:
                          selected
                              ? HexColor.fromHex(AppTheme.filledBox)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            selected
                                ? const Color(0xff1e1b57)
                                : Colors.transparent,
                        width: selected ? 1.5 : 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Radio button
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff1e1b57),
                              width: 2,
                            ),
                          ),
                          child:
                              selected
                                  ? Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff1e1b57),
                                      ),
                                    ),
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 12),

                        // Payment logo
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 60,
                            child: Image.asset(
                              method['logo']!,
                              //  width:  double.parse(method['size']!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          method['label']!,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: HexColor.fromHex(AppTheme.primaryColor),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, v, _) {
                return v
                    ? Center(child: getLoader())
                    : ElevatedButton(
                      onPressed: () async {
                        if (selectedMethod != -1) {
                          Map<String, dynamic> params = {};

                          params.putIfAbsent(
                            "amount_invested",
                            () =>
                                widget.amountInvested ??
                                widget.dealModel.minInvestment,
                          );

                          params.putIfAbsent(
                            "coupon_code",
                            () => widget.couponCode ?? 0,
                          );

                          params.putIfAbsent(
                            "wholesale_offer_id",
                            () => widget.dealModel.id,
                          );
                          params.putIfAbsent(
                            "quantity",
                            () => widget.dealModel.quantity,
                          );
                          params.putIfAbsent(
                            "transaction_id",
                            () => generateRandomString(10),
                          );

                          isLoading.value = true;
                          try {
                            await homePageController.subscribedToDeal(params);

                            homePageController.showSuccessSubscribeDeal(context);
                          } catch (e) {
                            handleException(context, e);
                          }
                          isLoading.value = false;

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "pay".tr,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${double.parse(widget.dealModel.retailPrice) * double.parse(widget.dealModel.minInvestment)}",
                          ),
                          SizedBox(width: 5),
                          SvgPicture.asset(
                            "assets/icons/sar.svg",
                            width: 15,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final rand = Random();
    return List.generate(
      length,
      (index) => chars[rand.nextInt(chars.length)],
    ).join();
  }
}
