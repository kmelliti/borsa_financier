import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREO17hg6KvLlweeZWN0LCEdi-OXM9qGpbQ9w&s",
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        "assets/icons/upload.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          TextField(controller: TextEditingController(text: "أحمد محمد العتيبي")),
          SizedBox(height: 20),
          TextField(controller: TextEditingController(text: "ahmad.otaibi@example.com")),

          SizedBox(height: 20),
          TextField(controller: TextEditingController(text: "+967712345678")),

          SizedBox(height: 20),
          TextField(controller: TextEditingController(text: "11/07/2000"),           decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset("assets/icons/file.svg" ,),
            ),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),),

          SizedBox(height: 20),
          TextField(
            controller: TextEditingController(text: "ذكر"),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: Text("save".tr)),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
