import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Building Number
            Text(
              "building_number".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#717088"),
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: "1234567"),
              decoration: InputDecoration(
                hintText: "enter_building_number".tr,
              ),
            ),
            const SizedBox(height: 20),

            // Sub Number
            Text(
              "sub_number".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#717088"),
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: "3000"),
              decoration: InputDecoration(
                hintText: "enter_sub_number".tr,
              ),
            ),
            const SizedBox(height: 20),

            // Street
            Text(
              "street".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#717088"),
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: "شارع الملك فهد"),
              decoration: InputDecoration(
                hintText: "enter_street".tr,
              ),
            ),
            const SizedBox(height: 20),

            // Neighborhood
            Text(
              "neighborhood".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#717088"),
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: "العليا"),
              decoration: InputDecoration(
                hintText: "enter_neighborhood".tr,
              ),
            ),
            const SizedBox(height: 20),

            // City
            Text(
              "city".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#717088"),
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: "الرياض"),
              decoration: InputDecoration(
                hintText: "enter_city".tr,
              ),
            ),
            const SizedBox(height: 20),

            // Postal Code
            Text(
              "postal_code".tr,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HexColor.fromHex("#717088"),
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: "12345"),
              decoration: InputDecoration(
                hintText: "enter_postal_code".tr,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement save address functionality
                Get.back();
              },
              child: Text("save".tr),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Helper function to show edit address dialog
void showEditAddressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "edit_address".tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const EditAddress(),
          ],
        ),
      ),
    ),
  );
}
