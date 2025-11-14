import 'dart:developer';
import 'dart:io';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:borsa_now_bis/screens/sign_up/presentation/controller/sign_up_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/di/di.dart';

typedef OnNextStep = void Function();

class PersonalInformationStep extends StatefulWidget {
  PersonalInformationStep({super.key, required this.onNextStep});

  final OnNextStep onNextStep;

  @override
  State<PersonalInformationStep> createState() => _PersonalInformationStepState();
}

class _PersonalInformationStepState extends State<PersonalInformationStep>

with SingleTickerProviderStateMixin{
  final ValueNotifier<String?> userImage = ValueNotifier(null);

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _birthdayController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _signUpController = getIt<SignUpController>();

  String? _gender;
  late final AnimationController controller;
  @override
  void initState() {

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_){
      _fullNameController.text = _signUpController.accountCreationParams.name ?? '';
      _birthdayController.text = _signUpController.accountCreationParams.birthday ?? '';
      _emailController.text = _signUpController.accountCreationParams.email ?? '';
      _phoneNumberController.text = _signUpController.accountCreationParams.phone ?? '';
      _gender = _signUpController.accountCreationParams.gender ;
      userImage.value = _signUpController.accountCreationParams.picture ?? null;
    });
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildSafeArea(context),
    );
  }

  SafeArea buildSafeArea(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: DottedBorder(
                    animation: controller,
                    options: RoundedRectDottedBorderOptions(

                      radius: const Radius.circular(60),
                      dashPattern: const [8, 4],
                      strokeWidth: 1,
                      color: HexColor.fromHex(AppTheme.primaryColor),
                    ),
                    child: ValueListenableBuilder(
                        valueListenable: userImage,
                        builder: (context, img, _) {
                          return InkWell(
                            onTap: () {
                              _picker.pickImage(source: ImageSource.gallery).then((value) {
                                if (value != null) {
                                  userImage.value = value.path;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor.fromHex("#F8F8FF"),
                                shape: BoxShape.circle,
                              ),
                              height: 120,
                              width: 120,
                              child: img != null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(File(img)),
                                    )
                                  : Column(
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
                          );
                        }),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'full_name'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field_is_required'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(labelText: 'email'.tr),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field_is_required'.tr;
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'phone_number'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field_is_required'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _birthdayController,
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
                      _birthdayController.text = DateFormat('dd-MM-yyyy').format(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'field_is_required'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'gender'.tr),
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
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {


                        if (_formKey.currentState!.validate()) {
                          _signUpController.accountCreationParams.name = _fullNameController.text;
                          _signUpController.accountCreationParams.email = _emailController.text;
                          _signUpController.accountCreationParams.phone = _phoneNumberController.text;
                          _signUpController.accountCreationParams.birthday = _birthdayController.text;
                          _signUpController.accountCreationParams.gender = _gender;
                          _signUpController.accountCreationParams.picture = userImage.value;

                         // _signUpController.signUpData['name'] = _fullNameController.text;
                         // _signUpController.signUpData['email'] = _emailController.text;
                         // _signUpController.signUpData['phone'] = _phoneNumberController.text;
                         // _signUpController.signUpData['birthday'] = _birthdayController.text;
                         // _signUpController.signUpData['gender'] = _gender;
                         // _signUpController.signUpData['picture'] = userImage.value;
                          widget.onNextStep();

                        }
                      },
                      child: Text('next'.tr)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
