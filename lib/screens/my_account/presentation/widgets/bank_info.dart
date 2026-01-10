import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/config/app_constants.dart';
import '../../../../core/models/bank_account_model.dart';
import '../../../../core/routes/app_routes.dart';
import '../manager/my_account_controller.dart';
import 'edit_bank_info.dart';



class BankInfo extends StatelessWidget {
   BankInfo({super.key});
  final ValueNotifier<List<BankAccountModel>> accounts = ValueNotifier([]);
  final MyAccountController controller = getIt();
  final ValueNotifier<bool> toggle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,true),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pushUpAnimation(
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/bank.svg"),
                    const SizedBox(width: 20),
                    Text(
                      "bank_info".tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                    ),
                    Spacer(),
                    bounceAnimation(
                      c: InkWell(
                        onTap: ()async{

                          try{
                          await  showModalBottomSheet(
                                showDragHandle: true,
                                isScrollControlled: true,
                                context: context, builder: (c){
                              return AddEditBankInfo();
                            });
                            toggle.value = !toggle.value;
                          }catch(e){
                            handleException(context, e);
                          }

                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                          ),
                          child: Icon(
                            Icons.add,
                            color: HexColor.fromHex(AppTheme.primaryColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              ValueListenableBuilder(
                valueListenable: toggle,
                builder: (context,_,__) {
                  return FutureBuilder(future: controller.getBankAccounts(), builder: (c,snap){
                    if(snap.connectionState == ConnectionState.waiting){
                      return Center(
                        child: getLoader(),
                      );
                    }
                    print("Data is ${snap.data}");
                    if(snap.connectionState == ConnectionState.done){

                    }
                    if(snap.connectionState == ConnectionState.done && !snap.hasError ){
                      accounts.value = snap.data!;
                      if(accounts.value.isEmpty){
                        return Center(
                          child: Text("no_data".tr),
                        );
                      }

                      return ValueListenableBuilder(valueListenable: accounts, builder: (_,list,_){
                        return ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (c,i){
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset("assets/icons/bank.svg"),
                                        SizedBox(width: 10),
                                        Text(
                                          "account_info".tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: HexColor.fromHex(AppTheme.primaryColor),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: ()async{
                                            try{
                                              await  showModalBottomSheet(
                                                  showDragHandle: true,
                                                  isScrollControlled: true,
                                                  context: context, builder: (c){
                                                return AddEditBankInfo(bankAccount: list[i],);
                                              });
                                              toggle.value = !toggle.value;
                                            }catch(e){
                                              handleException(context, e);
                                            }

                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.edit),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      banks.firstWhere((element) => element.id == list[i].bankId).name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: HexColor.fromHex(AppTheme.primaryColor),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    Text(
                                      list[i].accountNumber,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: HexColor.fromHex(AppTheme.primaryColor),

                                      ),
                                    ),
                                  ],
                                ),
                              );
                              return ListTile(

                                title: Text(banks.firstWhere((element) => element.id == list[i].bankId).name),
                                subtitle: Text(list[i].accountNumber),
                                trailing: InkWell(
                                  onTap: ()async{
                                    try{
                                      await  showModalBottomSheet(
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      context: context, builder: (c){
                                        return AddEditBankInfo(bankAccount: list[i],);
                                      });
                                      toggle.value = !toggle.value;
                                    }catch(e){
                                      handleException(context, e);
                                    }

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              );
                        }, );
                      });
                    }
                    return Container();
                  });
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, {required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: HexColor.fromHex("#717088"),
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: HexColor.fromHex(AppTheme.primaryColor),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
