import 'dart:collection';
import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/deal_product_model.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/manager/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/config/bottom_navigator.dart';
import '../../../../core/di/di.dart';
import '../../../../core/widgets/filters.dart';
import '../widgets/single_item_shopping_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomePageController _homePageController = getIt<HomePageController>();
  final ValueNotifier<Map<String,dynamic>?> filters = ValueNotifier(null);
  late final _pagingController = PagingController<int, DealProductModel>(
    getNextPageKey:
        (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _homePageController.getDealProducts(pageKey,filters.value),
  );






  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildAppBar(context,null,(v){
        log("$v");
        filters.value = {
          "product_name":v
        };
        _pagingController.refresh();
      }),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          width: double.infinity,
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
                        "mass_shopping".tr,
                        style: Theme
                            .of(
                          context,
                        )
                            .textTheme
                            .labelLarge
                            ?.copyWith(
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
                padding: EdgeInsets.only(bottom: 10),
                child: searchArea(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: PagingListener(
                  controller: _pagingController,
                  builder: (context, state, fetchNext) {
                    return PagedListView<int,DealProductModel>(

                      fetchNextPage: fetchNext,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, item, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: pushUpAnimation(SingleItemShoppingList(dealProductModel: item,)));
                        },

                      ),
                       state: state,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
                              ).applyDefaults(Theme.of(context).inputDecorationTheme),
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
                ValueListenableBuilder(
                  valueListenable: filters,
                  builder: (context,f,_) {
                    return GestureDetector(
                      onTapDown: (details) {
                        // This will be used for the tap effect
                        if(f!= null){
                          filters.value = null;
                          _pagingController.refresh();

                          return;
                        }
                        showModalBottomSheet(
                          showDragHandle: true,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery
                                .of(context)
                                .size
                                .height * 0.9,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          context: context,
                          builder: (context) {
                            return Filters(onFilter: (Map<String, dynamic> f) {
                              filters.value = f;

                              _pagingController.refresh();
                            },);
                          },
                        );
                      },
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: Duration(milliseconds: 1500),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 1.0 + (value * 0.1),
                            child:f != null ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex(AppTheme.primaryColor),
                                borderRadius: BorderRadius.circular(30),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${"reset_filters".tr}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SvgPicture.asset("assets/icons/filters.svg",color: Colors.white,),
                                ],
                              ),
                            ):Container(
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
                    );
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
