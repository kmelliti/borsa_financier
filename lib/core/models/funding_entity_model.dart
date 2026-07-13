// To parse this JSON data, do
//
//     final fundingEntityModel = fundingEntityModelFromJson(jsonString);

import 'dart:convert';

List<FundingEntityModel> fundingEntityModelFromJson(String str) => List<FundingEntityModel>.from(json.decode(str).map((x) => FundingEntityModel.fromJson(x)));

String fundingEntityModelToJson(List<FundingEntityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FundingEntityModel {
  int id;
  String name;
  String? picture;

  FundingEntityModel({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory FundingEntityModel.fromJson(Map<String, dynamic> json) => FundingEntityModel(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
  };
}
