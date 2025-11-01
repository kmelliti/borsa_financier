import 'package:borsa_now_bis/core/config/bottom_navigator.dart';
import 'package:borsa_now_bis/screens/home_page/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../../my_account/presentation/pages/my_account.dart';
import '../../../my_deals/presentation/pages/my_deals.dart';
import '../../../my_wallet/presentation/pages/my_wallet.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final ValueNotifier<int> indexWidget = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexWidget,
        builder: (c,i,_){

          print("Builder");
           switch(i){
            case 0:
              return HomePage(key: Key("home"),);
            case 1:
              return MyWallet();
            case 2:
              return MyDeals(key: Key("myDeals"),);
            case 3:
              return MyAccount();
            default:
              return HomePage();
          }
        },
      ),
      bottomNavigationBar: CustomBottomNav(onItemTapped: (int index) {
        indexWidget.value = index;
      }),
    );
  }
}
