import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  int selectedMethod = -1;

  final paymentMethods = [
    {
      'label': 'Apple Pay',
      'logo': 'assets/apple_pay.png',
      'size':"100"
    },
    {
      'label': 'Samsung Pay',
      'logo': 'assets/samsung_pay.png',
      'size':"100"
    },
    {
      'label': 'Google Pay',
      'logo': 'assets/google_pay.png',
      'size':"50"
    },
    {
      'label': 'Borsa Now',
      'logo': 'assets/borsa_now_pay.png',
      'size':"50"
    },
    {
      'label': 'ادفع بالبطاقة',
      'logo': 'assets/card.png',
      'size':"50"
    },
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
            Expanded(
              child: ListView.separated(
                itemCount: paymentMethods.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  final selected = selectedMethod == index;

                  return GestureDetector(
                    onTap: () => setState(() => selectedMethod = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: selected ? HexColor.fromHex(AppTheme.filledBox):Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selected ? const Color(0xff1e1b57) : Colors.transparent,
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
                            child: selected
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
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(


                                height: 60,
                                child: Image.asset(
                                  method['logo']!,
                                //  width:  double.parse(method['size']!),
                                  fit: BoxFit.contain
                                  ,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
