import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

typedef OnItemTapped = void Function(int index);
class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key, required this.onItemTapped});
  final OnItemTapped onItemTapped;
  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  final items = [
    {'icon': 'assets/icons/shop.svg', 'label': 'mass_shopping'.tr},
    {'icon': 'assets/icons/wallet.svg', 'label': 'my_wallet'.tr},
    {'icon': 'assets/icons/money.svg', 'label': 'my_deals'.tr},
    {'icon': 'assets/icons/account.svg', 'label': 'my_account'.tr},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: 120
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xfff8f8fc),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final selected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);

              widget.onItemTapped(index)
;            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(item['icon']!,color:  selected
                    ? HexColor.fromHex(AppTheme.primaryColor) // dark blue
                    : HexColor.fromHex("#393942"),),

                const SizedBox(height: 7),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected
                        ? HexColor.fromHex(AppTheme.primaryColor)
                        : HexColor.fromHex("#393942"),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: selected ? 20 : 0,
                  height: 3,
                  decoration: BoxDecoration(
                    color: const Color(0xff1e1b57),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
