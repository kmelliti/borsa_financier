import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:custom_dots_indicator/custom_dots_indicator.dart';
import 'package:flutter/material.dart';

final ScrollController _scrollController = ScrollController();

class PromosWidget extends StatelessWidget {
  final List promos;



  const PromosWidget({
    super.key, required this.promos,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 126,
      child: Column(
        children: [
          SizedBox(
            height: 106,
            child: ListView.separated(
              controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 242,
                    height: 106,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex(promos[index]["color"]),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: SizedBox(width: 120,
                                child: Text(promos[index]["title"],
                                  style: Theme.of(context,)
                                      .textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(100),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Text("${promos[index]["save"]}-",
                                  style: Theme.of(context,)
                                      .textTheme.bodyMedium?.copyWith(

                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10,);
                },
                itemCount: promos.length
            ),
          ),
          const SizedBox(height: 10),
          // 3. Add the sync-indicator
          SizedBox(
            height: 10,
            child: CustomDotsIndicator(
              controller: _scrollController,
              listLength: promos.length, // Total number of items in your list
              dotsCount: promos.length,   // Number of dots to display
              activeDotColor: Colors.grey[600],
              inactiveDotColor: Colors.grey[300]!,
            ),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Row(
        children: [
          Container(
            width: 242,
            height: 106,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#E5864C"),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SizedBox(width: 120,
                        child: Text("لا تفوت فرصة آيفون 17! ",
                          style: Theme.of(context,)
                              .textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("20%-",
                          style: Theme.of(context,)
                              .textTheme.bodyMedium?.copyWith(

                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )
                      )
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          Container(
            width: 242,
            height: 106,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#0B6648"),
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SizedBox(width: 120,
                        child: Text("أشهى مشروبات ستاربكس® بانتظارك!",
                          style: Theme.of(context,)
                              .textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withAlpha(100),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Text("20%-",
                          style: Theme.of(context,)
                              .textTheme.bodyMedium?.copyWith(

                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )
                      )
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}