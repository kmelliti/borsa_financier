import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '../../../core/config/app_constants.dart';
import '../../../core/di/di.dart';
import '../../../core/models/city_model.dart';
import '../../../core/theme/app_theme.dart';
import '../presentation/controller/sign_up_controller.dart';

typedef OnNextStep = void Function();
typedef OnBackStep = void Function();
class BankInfoStep extends StatefulWidget {
  const BankInfoStep({super.key, required this.onNextStep, required this.onBackStep});
  final OnNextStep onNextStep;
  final OnBackStep onBackStep;

  @override
  State<BankInfoStep> createState() => _BankInfoStepState();
}

class _BankInfoStepState extends State<BankInfoStep> {
  final _signUpController = getIt<SignUpController>();
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ibanNumberController = TextEditingController();
  final _ibanConfirmationController = TextEditingController();
  static String _displayStringForOption(LookUpModel lookup) => lookup.name;
    int? bankId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_){
      _bankNameController.text = _signUpController.accountCreationParams.bankName ?? '';
      _accountNumberController.text = _signUpController.accountCreationParams.accountNumber ?? '';
      _ibanNumberController.text = _signUpController.accountCreationParams.ibanNumber ?? '';
      _ibanConfirmationController.text = _signUpController.accountCreationParams.ibanNumber ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 30),
          Autocomplete<LookUpModel>(
            //   initialValue: TextEditingValue(text: cities.isNotEmpty ?cities.first.name :"" ) ,
            displayStringForOption: _displayStringForOption,
            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,

                decoration: InputDecoration(
                  hintText: 'bank_name'.tr,

                ).applyDefaults(Theme.of(context).inputDecorationTheme),
              );
            },

            // optionsViewBuilder: (context, controller, options) {
            //   return Container(
            //     color: Colors.white,
            //     child: ListView.builder(
            //       padding: EdgeInsets.all(10),
            //       itemCount: options.length,
            //       itemBuilder: (context, index) {
            //         final option = options.elementAt(index);
            //         return ListTile(
            //           title: Text(option.name),
            //           onTap: () {
            //             _cityController.text = option.name;
            //           },
            //         );
            //       },
            //     ),
            //   );
            // },
            optionsBuilder: (TextEditingValue textEditingValue) {
              return banks
                  .where(
                    (city) => city.name.toLowerCase().contains(
                  textEditingValue.text.toLowerCase(),
                ),
              )
                  .toList();
            },
            onSelected: (LookUpModel city) {
              _bankNameController.text = city.name;
              bankId= city.id;
            },
          ),
          // TextFormField(
          //   controller: _bankNameController,
          //   validator: (value) {
          //     if (value == null || value.isEmpty) {
          //       return "field_is_required".tr;
          //     }
          //     return null;
          //   },
          //   decoration: InputDecoration(
          //     labelText: 'bank_name'.tr,
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _accountNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'account_number'.tr,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _ibanNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'iban_number'.tr,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _ibanConfirmationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'iban_confirmation'.tr,
              border: OutlineInputBorder(),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {

                    widget.onBackStep();
                  },
                  style: AppTheme.outlinedButtonStyle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 10,),
                      Text('back'.tr),

                    ],
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    _signUpController.accountCreationParams.bankId = bankId;
                    _signUpController.accountCreationParams.bankName = _bankNameController.text;
                    _signUpController.accountCreationParams.accountNumber = _accountNumberController.text;
                    _signUpController.accountCreationParams.ibanNumber = _ibanNumberController.text;


                    widget.onNextStep();
                  }

                }, child: Text('next'.tr)),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}