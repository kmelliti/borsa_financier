// personal_identity.dart
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'edit_personal_identity.dart';

class PersonalIdentity extends StatelessWidget {
  const PersonalIdentity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pushUpAnimation(
              Row(
                children: [
                  SvgPicture.asset("assets/icons/badge.svg"),
                  const SizedBox(width: 20),
                  Text(
                    "identity_info".tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: bounceAnimation(
                c: SizedBox(
                  width: double.infinity,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "id_number".tr,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: HexColor.fromHex("#717088"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "enter_id_number".tr,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: HexColor.fromHex("#F8F8FF"),
                          border: Border.all(
                            color: HexColor.fromHex(AppTheme.primaryColor),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("upload_id".tr,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),),
                            SvgPicture.asset(
                              "assets/icons/upload.svg",
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                          ],
                        ),
                      ),



                      Spacer(),
                      ElevatedButton(onPressed: () {}, child: Text("save".tr)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
