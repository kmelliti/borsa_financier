import 'package:borsa_now_bis/screens/my_account/presentation/widgets/edit_address.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/widgets/edit_personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/utils.dart';
import '../../../../core/theme/app_theme.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pushUpAnimation(
              Row(
                children: [
                  SvgPicture.asset("assets/icons/pin.svg"),
                  SizedBox(width: 20),
                  Text(
                    "address".tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            bounceAnimation(
              c: Container(
                width: double.infinity,

                //  padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,

                  border: Border.all(
                    color: HexColor.fromHex(AppTheme.borderGrey),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                            child: Text(
                              "building_number".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#717088"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "1234567",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: HexColor.fromHex("#CDCCE0"), thickness: 1.5),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                            child: Text(
                              "sub_number".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#717088"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "3000",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: HexColor.fromHex("#CDCCE0"), thickness: 1.5),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                            child: Text(
                              "street".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#717088"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "شارع الملك فهد",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: HexColor.fromHex("#CDCCE0"), thickness: 1.5),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                            child: Text(
                              "neighborhood".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#717088"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "العليا",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: HexColor.fromHex("#CDCCE0"), thickness: 1.5),

                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                            child: Text(
                              "city".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#717088"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "الرياض",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: HexColor.fromHex("#CDCCE0"), thickness: 1.5),
                    
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex:3,
                            child: Text(
                              "zip".tr,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex("#717088"),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "11111",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: HexColor.fromHex(AppTheme.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),




            Spacer(),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    showDragHandle: true,
                    context: context, builder: (c){
                  return EditAddress(

                  );
                });
              },
              style: AppTheme.outlinedButtonStyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/edit.svg"),
                  SizedBox(width: 10),
                  Text(
                    "edit_info".tr,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
