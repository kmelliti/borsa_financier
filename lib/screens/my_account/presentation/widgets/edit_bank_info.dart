import 'dart:developer';

import 'package:borsa_now_bis/core/config/app_constants.dart';
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/user_model.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/manager/my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/di/di.dart';
import '../../../../core/models/bank_account_model.dart';
import '../../../../core/models/lookup_model.dart';

class AddEditBankInfo extends StatefulWidget {
  const AddEditBankInfo({super.key, this.bankAccount});

  final BankAccountModel? bankAccount;

  @override
  State<AddEditBankInfo> createState() => _AddEditBankInfoState();
}

class _AddEditBankInfoState extends State<AddEditBankInfo> {
  final AppServices _appServices = getIt();
  late UserModel userModel;
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  int? bankId;

  @override
  void initState() {
    userModel = _appServices.getUser();
    if (widget.bankAccount != null) {
      bankId = widget.bankAccount!.bankId;
      _bankNameController.text =
          banks
              .firstWhereOrNull(
                (test) =>
                    test.id.toString() == userModel.investor.bankId.toString(),
              )
              ?.name ??
          "";
      _accountNumberController.text = widget.bankAccount!.accountNumber;
    }

    super.initState();
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
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
            ButtonTheme(
              alignedDropdown: true,
              child: Autocomplete<LookUpModel>(
                //   initialValue: TextEditingValue(text: cities.isNotEmpty ?cities.first.name :"" ) ,
                displayStringForOption: displayStringForOption,
                initialValue: _bankNameController.value,
                fieldViewBuilder: (
                  context,
                  controller,
                  focusNode,
                  onFieldSubmitted,
                ) {
                  return TextFormField(
                    controller: controller,
                    focusNode: focusNode,

                    decoration: InputDecoration(
                      hintText: 'bank_name'.tr,
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                  );
                },

                optionsBuilder: (TextEditingValue textEditingValue) {
                  return banks
                      .where(
                        (city) => city.name.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ),
                      )
                      .toList();
                },
                onSelected: (LookUpModel bank) {
                  //   _bankNameController.text = bank.name;
                  bankId = bank.id;
                },
              ),
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
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(hintText: "enter_account_number".tr),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please_enter_account_number'.tr;
                }
                return null;
              },
            ),

            SizedBox(height: 40),
            // Save Button
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, val, _) {
                return val
                    ? Center(child: getLoader())
                    : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          isLoading.value = true;
                          MyAccountController controller = getIt();

                          Map<String, dynamic> params = {
                            "bank_id": bankId,
                            "account_number": _accountNumberController.text,
                          };

                          try {
                            if(widget.bankAccount != null){
                              params["user_bank_id"] = widget.bankAccount!.id;

                              log("account params ${params}");
                              await controller.updateBank(params);

                            }else{
                              await controller.addBank(params);
                            }
                            Get.back();
                          } catch (e) {
                            handleException(context, e);
                          }

                          isLoading.value = false;
                        }
                      },
                      child: Text("save".tr),
                    );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
