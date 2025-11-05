import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import '../../../../core/config/bottom_navigator.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class MyDeals extends StatelessWidget {
  const MyDeals({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animated title with fade and slide effect
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: Opacity(
                      opacity: value,
                      child: Text(
                        "my_deals".tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: bounceAnimation(c:
                       Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#E9F0FF"),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: HexColor.fromHex("#EBEBEB")),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/money_light.svg",
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                            SizedBox(height: 10),
                            getPriceInText(534.23),
                            SizedBox(height: 10),

                            Text("total_deals".tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: bounceAnimation(c:
                       Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#E6FFFA"),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: HexColor.fromHex("#EBEBEB")),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/money_bag.svg",
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                            SizedBox(height: 10),
                            getPriceInText(534.23),
                            SizedBox(height: 10),

                            Text("total_gains".tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 600),
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - value) * 20),
                    child: Opacity(
                      opacity: value,
                      child: Text(
                        "total_deals".tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              // Animated search bar
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeOutQuart,
                padding: EdgeInsets.only(bottom: 20),
                child: searchArea(),
              ),
              // Add your deals list here with staggered animations
              // Example:
              // ..._buildAnimatedDealsList(),
              SizedBox(height: 20),
              Container(

                child: ListView.builder(
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (c, index) {
                    return singleDeal(c);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
      leadingWidth: 120,
      elevation: 0,
      leading: Hero(
        tag: "a2",
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",
          ),
        ),
      ),
      actions: [
        Hero(
          tag: "a4",
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
            ),
            child: SvgPicture.asset("assets/icons/search.svg"),
          ),
        ),

        Hero(
          tag: "a3",
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 15),

            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,

              border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
            ),
            child: SvgPicture.asset("assets/icons/notifications.svg"),
          ),
        ),
      ],
    );
  }

  Widget searchArea() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: HexColor.fromHex(AppTheme.borderGrey),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "search_by_product_name".tr,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: InkWell(
                            onTap: () {},
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                                key: ValueKey('search_icon'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTapDown: (details) {
                    // This will be used for the tap effect
                  },
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: 0.0),
                    duration: Duration(milliseconds: 1500),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 1.0 + (value * 0.1),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: HexColor.fromHex(AppTheme.filledBox),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: HexColor.fromHex(AppTheme.borderGrey),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor.fromHex(
                                  AppTheme.primaryColor,
                                ).withOpacity(0.2 * (1 - value)),
                                spreadRadius: 2 * (1 - value),
                                blurRadius: 6 * (1 - value),
                              ),
                            ],
                          ),
                          child: SvgPicture.asset("assets/icons/filters.svg"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#EFEFE3"),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Image.asset("assets/icons/aa1.png")),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start
                    ,
                    children: [
                      Text(
                        "كولد برو بالتوت العليق والكريمة",
                        maxLines: 1,

                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
                          color: HexColor.fromHex(AppTheme.primaryColor),
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text("22-12-2025"),
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
                getPriceInText(10,Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),12),
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
                  "10",
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
                getPriceInText(10,Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),12),
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
                  "10 ${"unit_in_storage".tr}",
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
                getPriceInText(1500,Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
