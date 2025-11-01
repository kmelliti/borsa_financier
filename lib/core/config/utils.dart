import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../theme/app_theme.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

Widget getDiscountedPriceInText(double price) {
  return Stack(
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            price.toStringAsFixed(2),

            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex(AppTheme.borderGrey),
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(width: 5),
          SvgPicture.asset(
            "assets/icons/sar.svg",
            width: 20,
            color: HexColor.fromHex(AppTheme.borderGrey),
          ),
        ],
      ),
      Positioned.fill(
        child: Center(
          child: Container(
            color: HexColor.fromHex(AppTheme.primaryColor),
            height: 1,
          ),
        ),
      ),
    ],
  );
}

Widget getPriceInText(double price,[TextStyle? style,double ?pictureWidth]) {
  return Row(
    children: [
      Text(
        price.toStringAsFixed(2),
        style: style??TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: HexColor.fromHex(AppTheme.primaryColor),
          letterSpacing: 0.2,
        ),
      ),
      SizedBox(width: 5),
      SvgPicture.asset("assets/icons/sar.svg", width: pictureWidth ??20),
    ],
  );
}

Widget pushUpAnimation (Widget c){
  return  TweenAnimationBuilder(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 600),
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(0, (1 - value) * 20),
        child: Opacity(
          opacity: value,
          child: c,
        ),
      );
    },
  );
}

Widget bounceAnimation({required Widget c}){
  return   AnimatedContainer(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeOutQuart,
    padding: EdgeInsets.only(bottom: 10),
    child: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: c,
          ),
        );
      },
    ),
  );
}

TweenAnimationBuilder<double> buildTitle(String title) {
  return TweenAnimationBuilder(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 600),
    builder: (context, double value, child) {
      return Transform.translate(
        offset: Offset(0, (1 - value) * 20),
        child: Opacity(
          opacity: value,
          child: Text(
            title,
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
AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: HexColor.fromHex(AppTheme.appBackGroundColor),
    elevation: 0,
    leadingWidth: 80,
    leading: TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.5 + (value * 0.5),
            child: InkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: HexColor.fromHex(AppTheme.primaryColor),
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
                    child: SvgPicture.asset("assets/icons/notifications.svg"),
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
