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

  @override
  Widget build(BuildContext context) {
    late final _pagingController = PagingController<int, DealProductModel>(
      getNextPageKey:
          (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (pageKey) => _homePageController.getDealProducts(pageKey),
    );

    return Scaffold(
      appBar: buildAppBar(),
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
                        return Filters();
                      },
                    );
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

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
      elevation: 0,
      leadingWidth: 120,
      leading: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 800),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: 0.5 + (value * 0.5),
              child: Hero(
                tag: "a2",
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",
                  ),
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Hero(
                  tag: "a4",
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HexColor.fromHex(AppTheme.borderGrey),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Hero(
                  tag: "a3",
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HexColor.fromHex(AppTheme.borderGrey),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/notifications.svg",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
