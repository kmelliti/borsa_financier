import 'package:borsa_now_bis/core/services/my_account_services.dart';

import '../../../../core/models/bank_account_model.dart';
import '../../../../core/models/user_model.dart';

class MyAccountController {

  final MyAccountServices _myAccountServices;
  MyAccountController(this._myAccountServices);
  Future<UserModel> updatePersonalInfo(String? image ,Map<String,dynamic> params) async {
    return _myAccountServices.updatePersonalInfo(image, params);
  }
  Future<UserModel> updateAddress(Map<String, dynamic> params) async {
    return await _myAccountServices.updateAddress(params);
  }
  Future<UserModel> updateId(String? doc, String number,DateTime dob) async {
    return await _myAccountServices.updateId(doc, number,dob);
  }
  Future<void> updateBank(Map<String, dynamic> params) async {
    return _myAccountServices.updateBank(params);
  }
  Future<void> addBank(Map<String, dynamic> params) async {
    return _myAccountServices.addBank(params);
  }
  Future<void> updatePassword(Map<String, dynamic> params) async {
    return _myAccountServices.updatePassword(params);
  }
  Future<List<BankAccountModel>> getBankAccounts() async {
    return _myAccountServices.getBankAccounts();
  }




}