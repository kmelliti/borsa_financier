import 'package:borsa_now_bis/screens/my_deals/presentation/widgets/single_deal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/bottom_navigator.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home_page/data/models/deal_product_model.dart';
import '../../data/models/subscribed_deal_model.dart';
import '../manager/my_deals_controller.dart';

class MyDeals extends StatefulWidget {
   MyDeals({super.key});

  @override
  State<MyDeals> createState() => _MyDealsState();
}

class _MyDealsState extends State<MyDeals> {
   final MyDealsController _myDealsController = getIt();

   final ValueNotifier<Map<String,dynamic>?> filters = ValueNotifier(null);

   late final _pagingController = PagingController<int, SubscribedDealModel>(

     getNextPageKey: (state) {
       // This convenience getter checks if the last returned page is empty.
       // You can replace this with a check if the last page has returned less items than expected,
       // for a more efficient implementation.
       if (state.lastPageIsEmpty) return null;

       // This convenience getter increments the page key by 1, assuming keys start at 1.
       return state.nextIntPageKey;
     },

     fetchPage: (pageKey) => _myDealsController.getMyDeals(pageKey, filters.value),
   );

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, null, (v){

      }),
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
              FutureBuilder(
                future: _myDealsController.getDashboard( ),
                builder: (context,snap) {
                  if(snap.connectionState == ConnectionState.waiting){
                    return Center(
                      child: getLoader(),
                    );
                  }
                  if(snap.hasError){
                    return Center(
                      child: Text("error_title".tr),
                    );
                  }
                  Map<String,dynamic> data = snap.data!;
                  return Row(
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
                                getPriceInText(double.parse(data['total_deals'])),
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
                                getPriceInText(double.parse(data['total_profits'])),
                                SizedBox(height: 10),

                                Text("total_gains".tr),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
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
              PagingListener(
                controller: _pagingController,
                builder: (context, state, fetchNextPage) => PagedListView<int, SubscribedDealModel>(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  state: state,

                  fetchNextPage: fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate(
                    animateTransitions: true,
                    itemBuilder: (context, item, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: SingleMyDeal(deal : item)),
                  ),
                ),
              ),
              // Add your deals list here with staggered animations
              // Example:
              // ..._buildAnimatedDealsList(),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
  //     leadingWidth: 120,
  //     elevation: 0,
  //     leading: CircleAvatar(
  //       backgroundImage: NetworkImage(
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",
  //       ),
  //     ),
  //     actions: [
  //       Container(
  //         width: 50,
  //         height: 50,
  //         padding: EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           shape: BoxShape.circle,
  //           border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
  //         ),
  //         child: SvgPicture.asset("assets/icons/search.svg"),
  //       ),
  //
  //       Container(
  //         width: 50,
  //         height: 50,
  //         padding: EdgeInsets.all(15),
  //         margin: EdgeInsets.symmetric(horizontal: 15),
  //
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           shape: BoxShape.circle,
  //
  //           border: Border.all(color: HexColor.fromHex(AppTheme.borderGrey)),
  //         ),
  //         child: SvgPicture.asset("assets/icons/notifications.svg"),
  //       ),
  //     ],
  //   );
  // }

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
                              controller: searchController,
                              onChanged: (v){
                                if(v.isEmpty){
                                  filters.value = {};
                                  _pagingController.refresh();
                                }
                              },
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
                            onTap: () {
                              filters.value = {
                                "product_name": searchController.text,
                              };
                              _pagingController.refresh();


                            },
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
}
