// personal_identity.dart
import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/user_model.dart';
import 'package:borsa_now_bis/core/services/app_service.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/di/di.dart';
import '../manager/my_account_controller.dart';
import 'edit_personal_identity.dart';

class PersonalIdentity extends StatefulWidget {
  const PersonalIdentity({super.key});

  @override
  State<PersonalIdentity> createState() => _PersonalIdentityState();
}

class _PersonalIdentityState extends State<PersonalIdentity> {
  late UserModel userModel;

  final AppServices _appServices = getIt();
  final TextEditingController idNumberController = TextEditingController();
  final ValueNotifier<FilePickerResult?> idDoc = ValueNotifier(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final TextEditingController _birthdayController = TextEditingController();

  final MyAccountController _myAccountController = getIt();
  final _formKey = GlobalKey<FormState>();
  String documentName = "";

  @override
  void initState() {
    userModel = _appServices.getUser();
    idNumberController.text = userModel.investor.idNumber ?? "";
    documentName = userModel.investor.idDocumentPath.split("/").last ?? "";
    _birthdayController.text = userModel.birthdate != null ? df.format(userModel.birthdate!): "";


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, true),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
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
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: HexColor.fromHex("#717088")),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "field_is_required".tr;
                            }
                            return null;
                          },
                          controller: idNumberController,
                          decoration: InputDecoration(hintText: "enter_id_number".tr),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 30),

                        ValueListenableBuilder(
                          valueListenable: idDoc,
                          builder: (context, doc, _) {
                            return InkWell(
                              onTap: () {
                                FilePicker.pickFiles(allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'], type: FileType.custom).then((value) {
                                  idDoc.value = value;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: HexColor.fromHex("#F8F8FF"),
                                  border: Border.all(color: HexColor.fromHex(AppTheme.primaryColor), style: BorderStyle.solid),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      documentName.isNotEmpty
                                          ? documentName
                                          : doc == null
                                          ? "upload_id".tr
                                          : doc.files.first.name,
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      //  color: HexColor.fromHex(AppTheme.primaryColor),
                                      ),
                                    ),
                                    SvgPicture.asset("assets/icons/upload.svg", color: HexColor.fromHex(AppTheme.primaryColor)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "dob".tr,
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: HexColor.fromHex("#717088")),
                        ),
                        const SizedBox(height: 8),


                        TextFormField(
                          controller: _birthdayController,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,

                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: HexColor.fromHex(AppTheme.primaryColor),
                            ),
                          ),
                          onTap: () async {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value == null) {
                                return;
                              }
                              _birthdayController.text = df.format(value);
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field_is_required'.tr;
                            }
                            return null;
                          },
                        ),

                        Spacer(),
                        ValueListenableBuilder(
                          valueListenable: isLoading,
                          builder: (context, val, _) {
                            return val
                                ? Center(child: getLoader())
                                : ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    isLoading.value = true;
                                    await _myAccountController.updateId(idDoc.value?.files.first.path, idNumberController.text,df.parse
                                      (_birthdayController.text));

                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("update_success".tr)));
                                  }
                                } catch (e) {
                                  handleException(context, e);
                                } finally {
                                  isLoading.value = false;
                                }
                              },
                              child: Text("save".tr),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
