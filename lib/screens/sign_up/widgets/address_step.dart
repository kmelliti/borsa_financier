import 'package:borsa_now_bis/core/models/city_model.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '../../../core/config/app_constants.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/app_theme.dart';
import '../presentation/controller/sign_up_controller.dart';

typedef OnNextStep = void Function();
typedef OnBackStep = void Function();

class AddressStep extends StatefulWidget {
  const AddressStep({
    super.key,
    required this.onNextStep,
    required this.onBackStep,
  });

  final OnNextStep onNextStep;
  final OnBackStep onBackStep;

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  final TextEditingController _buildingNumberController =
      TextEditingController();
  final TextEditingController _subNumberController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final _signUpController = getIt<SignUpController>();
  final _formKey = GlobalKey<FormState>();
  int? cityId ;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _buildingNumberController.text =
          _signUpController.accountCreationParams.buildingNumber ?? '';
      _subNumberController.text =
          _signUpController.accountCreationParams.unitNumber ?? '';
      _streetController.text =
          _signUpController.accountCreationParams.street ?? '';
      _neighborhoodController.text =
          _signUpController.accountCreationParams.district ?? '';
      _cityController.text =
          _signUpController.accountCreationParams.cityName ??"";
      _zipController.text =
          _signUpController.accountCreationParams.postalCode ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    _buildingNumberController.dispose();
    _subNumberController.dispose();
    _streetController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  static String _displayStringForOption(LookUpModel lookup) => lookup.name;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 30),
          TextFormField(
            controller: _buildingNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'building_number'.tr,
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),
          TextFormField(
            controller: _subNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'sub_number'.tr,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _streetController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              labelText: 'street'.tr,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _neighborhoodController,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              labelText: 'district'.tr,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Autocomplete<LookUpModel>(
         //   initialValue: TextEditingValue(text: cities.isNotEmpty ?cities.first.name :"" ) ,
            displayStringForOption: _displayStringForOption,

            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: controller,
                focusNode: focusNode,

                decoration: InputDecoration(
                  hintText: 'city'.tr,

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
              return cities
                  .where(
                    (city) => city.name.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    ),
                  )
                  .toList();
            },
            onSelected: (LookUpModel city) {
              _cityController.text = city.name;
              cityId = city.id;
            },
          ),
          // TextFormField(
          //   controller: _cityController,
          //   decoration: InputDecoration(
          //     labelText: 'city'.tr,
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _zipController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "field_is_required".tr;
              }
              return null;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'zip'.tr,
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
                      SizedBox(width: 10),
                      Text('back'.tr),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 50),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signUpController.accountCreationParams.buildingNumber =
                          _buildingNumberController.text;
                      _signUpController.accountCreationParams.unitNumber =
                          _subNumberController.text;
                      _signUpController.accountCreationParams.street =
                          _streetController.text;
                      _signUpController.accountCreationParams.district =
                          _neighborhoodController.text;
                      _signUpController.accountCreationParams.cityId =
                          cityId;
                      _signUpController.accountCreationParams.cityName =
                          _cityController.text;
                      _signUpController.accountCreationParams.postalCode =
                          _zipController.text;

                      // _signUpController.signUpData['buildingNumber'] = _buildingNumberController.text;
                      // _signUpController.signUpData['subNumber'] = _subNumberController.text;
                      // _signUpController.signUpData['street'] = _streetController.text;
                      // _signUpController.signUpData['neighborhood'] = _neighborhoodController.text;
                      // _signUpController.signUpData['city'] = _cityController.text;
                      // _signUpController.signUpData['zipCode'] = _zipController.text;

                      widget.onNextStep();
                    }
                  },
                  child: Text('next'.tr),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
