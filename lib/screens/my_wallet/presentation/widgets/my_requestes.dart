import 'package:borsa_now_bis/screens/my_wallet/presentation/widgets/request_withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/animated_buttons.dart';
import '../../../../core/theme/app_theme.dart';
import 'fund_request.dart';

enum Status { accepted, rejected, pending }

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    [
                      dropdownMonth(),
                      const SizedBox(width: 10),
                      dropdownYear(),
                      const SizedBox(width: 10),
                      dropdownCategory(),
                    ].map((widget) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: widget,
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: buildButtons(),
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: singleRequest(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildButtons() {
    return Column(
      children: [
        AnimatedButton(onPressed: () {
          Get.to(WithdrawRequestPage());
        }, child: Text("withdraw".tr)),
        const SizedBox(height: 10),
        AnimatedButton(
          onPressed: () {
            Get.to(FundRequest());
          },
          style: AppTheme.outlinedButtonStyle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("request_funds".tr),
              const SizedBox(width: 10),
              SvgPicture.asset(
                "assets/icons/money.svg",
                width: 20,
                color: HexColor.fromHex(AppTheme.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dropdownMonth() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          hint: Text("month".tr),
          items: const [
            DropdownMenuItem(value: 'Small', child: Text('Small')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Large', child: Text('Large')),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget dropdownYear() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          hint: Text("year".tr),

          items: const [
            DropdownMenuItem(value: 'Small', child: Text('Small')),
            DropdownMenuItem(value: 'Medium', child: Text('Medium')),
            DropdownMenuItem(value: 'Large', child: Text('Large')),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget dropdownCategory() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: null,
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          hint: Text("category_request".tr),

          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget singleRequest(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.95, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: GestureDetector(
        onTapDown: (_) {
          // Animation handled by TweenAnimationBuilder
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#F8F8FF"),
                      border: Border.all(
                        color: HexColor.fromHex(AppTheme.borderGrey),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/fly_money.svg",
                          width: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "request_funds".tr,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: HexColor.fromHex(AppTheme.primaryColor),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  getStatusWidget(Status.accepted)
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text("date".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                  Spacer(),
                  Text("12/12/2022",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5E5D68"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("amount".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                  Spacer(),
                  Row(
                    children: [
                      Text("1000.0",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: HexColor.fromHex("#5E5D68"),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                     SizedBox(width: 5,),
                     SvgPicture.asset("assets/icons/sar.svg", width: 18,color: HexColor.fromHex("#5E5D68"),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("account_details".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                  Spacer(),
                  Text("بنك الراجحي",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5E5D68"),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  
  Widget getStatusWidget(Status stat){
    String status;
    switch (stat) {
      case Status.accepted:
        status = "accepted".tr;
        break;
      case Status.rejected:
        status = "rejected".tr;
        break;
      case Status.pending:
        status = "pending".tr;
        break;
    }
    Color color;
    switch (stat) {
      case Status.accepted:
        color = HexColor.fromHex("#4BC27E");
        break;
      case Status.rejected:
        color = HexColor.fromHex("#E62F29");
        break;
      case Status.pending:
        color = HexColor.fromHex("#FF7700");
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(status,style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),),
    );
  }


}
