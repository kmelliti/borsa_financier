import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class FundRequest extends StatefulWidget {
  const FundRequest({super.key});

  @override
  State<FundRequest> createState() => _FundRequestState();
}

class _FundRequestState extends State<FundRequest> {
  int selectedMethod = -1;

  final paymentMethods = [
    {'label': 'Borsa Now', 'logo': 'assets/borsa_now_pay.png'},
    {'label': 'ادفع بالبطاقة', 'logo': 'assets/card.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
        elevation: 0,
        centerTitle: false,

        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),
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
          'fund_request'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'أدخل المبلغ',
                suffixIcon: Container(
                  padding: EdgeInsets.all(15),

                    child: SvgPicture.asset("assets/icons/sar.svg" ,color: HexColor.fromHex("#020202"),)),
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
            SizedBox(height: 20),
            
            ListView.separated(
              shrinkWrap: true,
              itemCount: paymentMethods.length,
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
                      vertical: 20,
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
                                : HexColor.fromHex(AppTheme.borderGrey),
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
                        // Payment logo
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              method['logo']!,
                              height: 38,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Radio button
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xff1e1b57),
                              width: 1,
                            ),
                          ),
                          child:
                              selected
                                  ? Center(
                                    child: Container(
                                      width: 15,
                                      height: 15,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff1e1b57),
                                      ),
                                    ),
                                  )
                                  : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){}, child: Text("apply_request_now".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
              fontSize: 20,
            ),))

          ],
        ),
      ),
    );
  }
}
