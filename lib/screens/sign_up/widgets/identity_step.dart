import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/config/utils.dart';
import '../../../core/di/di.dart';
import '../../../core/theme/app_theme.dart';
import '../presentation/controller/sign_up_controller.dart';

typedef OnNextStep = void Function();
typedef OnBackStep = void Function();

class IdentityStep extends StatefulWidget {
  IdentityStep({super.key, required this.onNextStep, required this.onBackStep});

  final OnNextStep onNextStep;
  final OnBackStep onBackStep;

  @override
  State<IdentityStep> createState() => _IdentityStepState();
}

class _IdentityStepState extends State<IdentityStep> {
  final _signUpController = getIt<SignUpController>();
  final ValueNotifier<String?> idDocument = ValueNotifier(null);
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_){
      _idNumberController.text = _signUpController.accountCreationParams.idNumber ?? '';
      idDocument.value = _signUpController.accountCreationParams.idDocumentPath ?? null;
    });
    // if (_signUpController.signUpData.isNotEmpty) {
    //   _idNumberController.text = _signUpController.signUpData['idNumber'] ?? '';
    //   WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
    //     idDocument.value =
    //         _signUpController.signUpData['idDocumentPath'] ?? null;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
          key: _formKey,
            child: Column(
        children: [
          SizedBox(height: 40),
          TextFormField(
            controller: _idNumberController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "enter_id_number".tr;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "enter_id_number".tr,

              hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: HexColor.fromHex(AppTheme.hintColor),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),

          ValueListenableBuilder(
            valueListenable: idDocument,
            builder: (context, value, child) {
              return InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    idDocument.value = file.path;
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                      Text(
                        value == null
                            ? "upload_id".tr
                            : value.split("/").last.toString(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: HexColor.fromHex(AppTheme.primaryColor),
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/icons/upload.svg",
                        color: HexColor.fromHex(AppTheme.primaryColor),
                      ),
                    ],
                  ),
                ),
              );
            },
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
                      _signUpController.accountCreationParams.idNumber = _idNumberController.text;
                      _signUpController.accountCreationParams.idDocumentPath = idDocument.value;
                      // _signUpController.signUpData['idNumber'] =
                      //     _idNumberController.text;
                      // _signUpController.signUpData['idDocumentPath'] =
                      //     idDocument.value;
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
