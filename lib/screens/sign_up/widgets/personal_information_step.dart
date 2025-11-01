import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PersonalInformationStep extends StatelessWidget {
  const PersonalInformationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 80,
      centerTitle: false,
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
      title: Text('create_account'.tr,style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: HexColor.fromHex(AppTheme.primaryColor),
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),),
    ),
      body: buildSafeArea(context),
    );
  }

  SafeArea buildSafeArea(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('personal_information'.tr,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: HexColor.fromHex("#393942"),
            ),),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.2,
              minHeight: 6,
              color: HexColor.fromHex(AppTheme.primaryColor),
              backgroundColor: HexColor.fromHex("#DEDDFF"),
              borderRadius: BorderRadius.circular(6),
            ),
            const SizedBox(height: 30),
            Center(
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  radius: const Radius.circular(60),
                  dashPattern: const [8, 4],
                  strokeWidth: 1,
                  color: HexColor.fromHex(AppTheme.primaryColor),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#F8F8FF"),
                    shape: BoxShape.circle,
                  ),
                  height: 120,
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/upload.svg",
                        width: 15,
                        color: HexColor.fromHex(AppTheme.primaryColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'upload_photo'.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: HexColor.fromHex(AppTheme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(labelText: 'full_name'.tr),
            ),
            const SizedBox(height: 20),
            TextFormField(decoration: InputDecoration(labelText: 'email'.tr)),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'phone_number'.tr),
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'dob'.tr,
                suffixIcon: Icon(Icons.calendar_today_outlined,color: HexColor.fromHex(AppTheme.primaryColor),),
              ),
              onTap: () async {
                // Show date picker
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'gender'.tr),
              items: [
                DropdownMenuItem(value: 'male', child: Text('male'.tr)),
                DropdownMenuItem(value: 'female', child: Text('female'.tr)),
              ],
              onChanged: (value) {},
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text('next'.tr)),
            ),
          ],
        ),
      ),
    );
  }
}
