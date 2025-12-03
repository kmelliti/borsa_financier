import 'dart:io';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/models/user_model.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/my_account/presentation/manager/my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/config/app_constants.dart';

class EditPersonalInfo extends StatefulWidget {
  final UserModel user;

  const EditPersonalInfo({super.key, required this.user});

  @override
  State<EditPersonalInfo> createState() => _EditPersonalInfoState();
}

class _EditPersonalInfoState extends State<EditPersonalInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  String? _gender;

  final MyAccountController _controller = getIt();
  String? image ;
  final ImagePicker _picker = ImagePicker();
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  late UserModel userModel;
  @override
  void initState() {
    userModel = widget.user;
    _nameController.text = userModel.name;
    _emailController.text = userModel.email;
    _phoneController.text = userModel.phone;
    _dobController.text = userModel.birthdate != null ? df.format(userModel.birthdate!): "";
    _genderController.text = userModel.gender ?? "";
    _gender = userModel.gender;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
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
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: image != null ? Image.file(File(image!)).image:NetworkImage(
                          "$baseUrlImage/${userModel.picture}",
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
                      child: InkWell(
                        onTap: ()async{
                          final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
                          if(file != null){
                            image = file.path;
                            setState(() {

                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            "assets/icons/upload.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field_is_required'.tr;
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field_is_required'.tr;
                }
                return null;
              },
            ),

            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textAlign: Get.locale?.countryCode != "ar" ? TextAlign.right : TextAlign.left,
              textDirection: Get.locale?.countryCode == "ar" ? TextDirection.rtl : TextDirection.ltr,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field_is_required'.tr;
                }
                return null;
              },
            ),

            SizedBox(height: 20),
            TextFormField(
              controller: _dobController,
              keyboardType: TextInputType.datetime,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'dob'.tr,
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
                  _dobController.text =df.format(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'field_is_required'.tr;
                }
                return null;
              },
            ),

            SizedBox(height: 20),
            ButtonTheme(
              alignedDropdown: true,

              child: DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(labelText: 'gender'.tr,contentPadding: EdgeInsets.all( 15)),
                items: [
                  DropdownMenuItem(value: "male", child: Text('male'.tr)),
                  DropdownMenuItem(value: "female", child: Text('female'.tr)),
                ],
                onChanged: (value) {
                  _gender = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'field_is_required'.tr;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context,val,_) {
                return val ? getLoader() : ElevatedButton(onPressed: ()async {

                  if(_formKey.currentState!.validate()){
                    Map<String,dynamic> params = {
                      "name": _nameController.text,
                      "email": _emailController.text,
                      "phone": _phoneController.text,
                      "birthdate": _dobController.text,
                      "gender": _gender,
                    };
                    isLoading.value = true;
                    try{
                    UserModel newUser = await  _controller.updatePersonalInfo(image,params);
                    Get.back(result: newUser);

                    }
                    catch(e){
                      handleException(context, e);
                    }
                    isLoading.value = false;
                  }
                }, child: Text("save".tr));
              }
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
