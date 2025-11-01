import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBankInfo extends StatefulWidget {
  const EditBankInfo({super.key});

  @override
  State<EditBankInfo> createState() => _EditBankInfoState();
}

class _EditBankInfoState extends State<EditBankInfo> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController(text: "البنك الأهلي السعودي");
  final _accountNumberController = TextEditingController(text: "SA03 8000 0000 6080 1016 7519");
  final _ibanNumberController = TextEditingController(text: "SA03 8000 0000 6080 1016 7519");
  final _ibanConfirmController = TextEditingController(text: "SA03 8000 0000 6080 1016 7519");

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ibanNumberController.dispose();
    _ibanConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bank Name
          Text(
            "bank_name".tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: HexColor.fromHex("#717088"),
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _bankNameController,
            decoration: InputDecoration(
              hintText: "enter_bank_name".tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_bank_name'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Account Number
          Text(
            "account_number".tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: HexColor.fromHex("#717088"),
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _accountNumberController,
            decoration: InputDecoration(
              hintText: "enter_account_number".tr,
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_account_number'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // IBAN Number
          Text(
            "iban_number".tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: HexColor.fromHex("#717088"),
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _ibanNumberController,
            decoration: InputDecoration(
              hintText: "enter_iban_number".tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_enter_iban_number'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // IBAN Confirmation
          Text(
            "confirm_iban_number".tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: HexColor.fromHex("#717088"),
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _ibanConfirmController,
            decoration: InputDecoration(
              hintText: "confirm_iban_number".tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please_confirm_iban_number'.tr;
              }
              if (value != _ibanNumberController.text) {
                return 'iban_numbers_do_not_match'.tr;
              }
              return null;
            },
          ),
          Spacer(),

          // Save Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // TODO: Implement save functionality
                Get.back();
              }
            },
            child: Text("save".tr),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
