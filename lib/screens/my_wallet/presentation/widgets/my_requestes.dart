import 'package:borsa_now_bis/core/models/my_request_fund_model.dart';
import 'package:borsa_now_bis/screens/my_wallet/presentation/manager/my_wallet_controller.dart';
import 'package:borsa_now_bis/screens/my_wallet/presentation/widgets/request_withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';
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
  final MyWalletController _controller = getIt();

  late final _pagingController = PagingController<int, MyRequestFundModel>(
    getNextPageKey:
        (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _controller.getMyFundRequests(pageKey),
  );


  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  ValueNotifier<bool> shakeUp = ValueNotifier(false);


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              dateSelector((month){}, (year){}, true),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children:
              //         [
              //
              //           const SizedBox(width: 10),
              //           dropdownCategory(),
              //         ].map((widget) {
              //           return SlideTransition(
              //             position: _slideAnimation,
              //             child: FadeTransition(
              //               opacity: _fadeAnimation,
              //               child: widget,
              //             ),
              //           );
              //         }).toList(),
              //   ),
              // ),
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
                  child:  PagingListener(

                    controller: _pagingController,


                    builder: (context, state, fetchNext) {
                      return PagedListView<int,MyRequestFundModel>(

                        physics: NeverScrollableScrollPhysics(),
                        fetchNextPage: fetchNext,
                        shrinkWrap: true,
                        builderDelegate: PagedChildBuilderDelegate(
                          noItemsFoundIndicatorBuilder: (_){
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 80.0),
                                child: Text("no_data".tr),
                              ),
                            );
                          },
                          itemBuilder: (context, item, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: singleRequest(context,item),
                            );
                          },

                        ),
                        state: state,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
          onPressed: () async{
            await Get.to(()=>FundRequest());
            _pagingController.refresh();
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

  Widget singleRequest(BuildContext context, MyRequestFundModel item) {
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
                      horizontal: 25,
                      vertical: 5,
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
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  getStatusWidget(item.status)
                ],
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  Text("date".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Spacer(),
                  Text(df.format(item.createdAt),style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5E5D68"),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("amount".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Spacer(),
                  Row(
                    children: [
                      Text(item.amount,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: HexColor.fromHex("#5E5D68"),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
                  Text("funding_entity".tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#1E1D33"),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Spacer(),
                  Text(item.entity.name,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: HexColor.fromHex("#5E5D68"),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  
  Widget getStatusWidget(String stat){
    String status;
    switch (stat) {
      case "accepted":
        status = "accepted".tr;
        break;
      case "rejected":
        status = "rejected".tr;
        break;
      case "requested":
        status = "requested".tr;
      default :
       status = stat;
    }
    Color? color;
    switch (stat) {
      case "accepted":
        color = HexColor.fromHex("#4BC27E");
        break;
      case "rejected":
        color = HexColor.fromHex("#E62F29");
        break;
      case "requested":
        color = HexColor.fromHex("#FF7700");
      default :
        color = Colors.black;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
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
