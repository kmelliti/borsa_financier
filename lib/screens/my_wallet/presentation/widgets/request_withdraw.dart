import 'package:borsa_now_bis/screens/my_wallet/presentation/manager/my_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/config/utils.dart';
import '../../../../core/di/di.dart';
import '../../../../core/models/bank_account_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../my_account/presentation/manager/my_account_controller.dart';

class WithdrawRequestPage extends StatelessWidget {
  WithdrawRequestPage({super.key});

  final MyAccountController controller = getIt();
  final MyWalletController myWalletController = getIt();

  final ValueNotifier<int?> selectedAccount = ValueNotifier<int?>(null);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        leadingWidth: 100,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: Icon(
              Icons.arrow_back,
              color: HexColor.fromHex(AppTheme.primaryColor),
            ),
          ),
        ),
        title: Text(
          'request_withdraw'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: HexColor.fromHex(AppTheme.primaryColor),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            fontSize: 20,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // مبلغ الإدخال
              TextField(
                controller: amountController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'enter_amount'.tr,
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  // suffixIcon: SvgPicture.asset("assets/icons/sar.svg" ,height: 5,),
                  //  contentPadding:
                  //  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  //  border: OutlineInputBorder(
                  //    borderRadius: BorderRadius.circular(25),
                  //    borderSide: BorderSide(color: Colors.grey.shade300),
                  //  ),
                ).applyDefaults(Theme.of(context).inputDecorationTheme),
              ),

              const SizedBox(height: 20),

              // معلومات الحساب
              FutureBuilder(
                future: controller.getBankAccounts(),
                builder: (c, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: getLoader());
                  }
                  print("Data is ${snap.data}");
                  if (snap.connectionState == ConnectionState.done) {}
                  if (snap.connectionState == ConnectionState.done &&
                      !snap.hasError) {
                    List<BankAccountModel> list = snap.data!;
                    if (list.isEmpty) {
                      return Center(child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("no_bank_add_bank".tr),
                      ));
                    }

                    return ValueListenableBuilder(
                      valueListenable: selectedAccount,
                      builder: (context, accountId, _) {
                        return ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          itemBuilder: (c, i) {
                            return InkWell(
                              onTap: () {
                                selectedAccount.value = list[i].id;
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border:
                                      list[i].id == accountId
                                          ? Border.all(
                                            color: HexColor.fromHex(
                                              AppTheme.primaryColor,
                                            ),
                                            width: 2,
                                          )
                                          : Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/bank.svg",
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "account_info".tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: HexColor.fromHex(
                                              AppTheme.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      banks
                                          .firstWhere(
                                            (element) =>
                                                element.id == list[i].bankId,
                                          )
                                          .name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: HexColor.fromHex(
                                          AppTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    Text(
                                      list[i].accountNumber,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: HexColor.fromHex(
                                          AppTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),

              const SizedBox(height: 15),

              // InkWell(
              //   child: Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              //     decoration: BoxDecoration(
              //       color: HexColor.fromHex(AppTheme.filledBox),
              //       borderRadius: BorderRadius.circular(50),
              //       border: Border.all(
              //         color: HexColor.fromHex(AppTheme.primaryColor),
              //       ),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "add_new_bank".tr,
              //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //             color: HexColor.fromHex(AppTheme.primaryColor),
              //             fontWeight: FontWeight.w500,
              //             letterSpacing: 0.2,
              //             fontSize: 18,
              //           ),
              //         ),
              //
              //         Icon(
              //           Icons.add,
              //           color: HexColor.fromHex(AppTheme.primaryColor),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 25),

              // زر إرسال الطلب
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, value, _) {
                  return value ? Center(child: getLoader(),) :ElevatedButton(
                    onPressed: () async{
                      if (amountController.text.isEmpty) {
                        showErrorDialog(context, "enter_amount".tr);
                        return;
                      }
                      if (selectedAccount.value == null) {
                        showErrorDialog(context, "select_account".tr);
                        return;
                      }
                      Map<String, dynamic> params = {
                        "amount": amountController.text,
                        "bank_user_id": selectedAccount.value,
                      };
                      try {
                        isLoading.value = true;
                        await myWalletController.withdrawRequest(params);
                        myWalletController.showSuccessWithdrawRequest(context);
                      } catch (e, s) {
                        myWalletController.showErrorWithdrawRequest(context, null);
                      }
                      isLoading.value = false;
                    },

                    child: Text("send_request".tr),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
