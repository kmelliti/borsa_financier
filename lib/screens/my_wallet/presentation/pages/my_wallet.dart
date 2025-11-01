import 'package:borsa_now_bis/screens/my_wallet/presentation/widgets/general_resume.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/my_requestes.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(),
            SizedBox(height: 20), // Add some spacing
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 48, // Fixed height for TabBar
                      child: TabBar(
                        labelColor: Color(0xFF1E1A55),
                        unselectedLabelColor: Color(0xFF1E1A55),
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 2.5,
                            color: Color(0xFF1E1A55),
                          ),
                          insets: EdgeInsets.zero,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: <Widget>[
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/chart.svg"),
                                SizedBox(width: 10),
                                Text(
                                  "general_re".tr,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/icons/request.svg"),
                                SizedBox(width: 10),
                                Text(
                                  "my_requests".tr,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20), // Add spacing between TabBar and content
                    Expanded(
                      child: TabBarView(
                        children: [
                          GeneralResume(),
                          MyRequests(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  TweenAnimationBuilder<double> buildTitle() {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: Opacity(
            opacity: value,
            child: Text(
              "my_wallet".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      },
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
}
