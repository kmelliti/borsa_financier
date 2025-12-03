// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:borsa_now_bis/core/config/app_constants.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String name;
  String picture;
  String phone;
  String email;
  DateTime? birthdate;
  String gender;
  String role;
  String kycStatus;
  int isDeleted;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  Investor investor;

  UserModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.phone,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.role,
    required this.kycStatus,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.investor,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    phone: json["phone"],
    email: json["email"],
    birthdate: json["birthdate"] != null ?DateTime.parse(json["birthdate"]):null,
    gender: json["gender"],
    role: json["role"],
    kycStatus: json["kyc_status"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    investor: Investor.fromJson(json["investor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "phone": phone,
    "email": email,
    "birthdate": birthdate  != null ? df.format(birthdate!):null,
    "gender": gender,
    "role": role,
    "kyc_status": kycStatus,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "investor": investor.toJson(),
  };
}

class Investor {
  int id;
  int userId;
  int cityId;
  int bankId;
  String idNumber;
  String idDocumentPath;
  String buildingNumber;
  String unitNumber;
  String street;
  String district;
  String postalCode;
  String accountNumber;
  String ibanNumber;
  String totalInvested;
  String totalProfit;
  int isActive;
  int isDeleted;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;

  Investor({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.bankId,
    required this.idNumber,
    required this.idDocumentPath,
    required this.buildingNumber,
    required this.unitNumber,
    required this.street,
    required this.district,
    required this.postalCode,
    required this.accountNumber,
    required this.ibanNumber,
    required this.totalInvested,
    required this.totalProfit,
    required this.isActive,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Investor.fromJson(Map<String, dynamic> json) => Investor(
    id: json["id"],
    userId: json["user_id"],
    cityId: json["city_id"],
    bankId: json["bank_id"],
    idNumber: json["id_number"],
    idDocumentPath: json["id_document_path"],
    buildingNumber: json["building_number"],
    unitNumber: json["unit_number"],
    street: json["street"],
    district: json["district"],
    postalCode: json["postal_code"],
    accountNumber: json["account_number"],
    ibanNumber: json["iban_number"],
    totalInvested: json["total_invested"],
    totalProfit: json["total_profit"],
    isActive: json["is_active"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "city_id": cityId,
    "bank_id": bankId,
    "id_number": idNumber,
    "id_document_path": idDocumentPath,
    "building_number": buildingNumber,
    "unit_number": unitNumber,
    "street": street,
    "district": district,
    "postal_code": postalCode,
    "account_number": accountNumber,
    "iban_number": ibanNumber,
    "total_invested": totalInvested,
    "total_profit": totalProfit,
    "is_active": isActive,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
