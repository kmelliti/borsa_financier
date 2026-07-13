// To parse this JSON data, do
//
//     final bankAccountModel = bankAccountModelFromJson(jsonString);

import 'dart:convert';

List<BankAccountModel> bankAccountModelFromJson(String str) => List<BankAccountModel>.from(json.decode(str).map((x) => BankAccountModel.fromJson(x)));

String bankAccountModelToJson(List<BankAccountModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankAccountModel {
  int id;
  int userId;
  int bankId;
  String accountNumber;
  String ibanNumber;


  BankAccountModel({
    required this.id,
    required this.userId,
    required this.bankId,
    required this.accountNumber,
    required this.ibanNumber,

  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) => BankAccountModel(
    id: json["id"],
    userId: json["user_id"],
    bankId: json["bank_id"],
    accountNumber: json["account_number"],
    ibanNumber:json.containsKey("iban_number")? json["iban_number"]:"",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "bank_id": bankId,
    "account_number": accountNumber,
    "iban_number": ibanNumber,

  };
}
