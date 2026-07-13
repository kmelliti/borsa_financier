// To parse this JSON data, do
//
//     final myRequestFundModel = myRequestFundModelFromJson(jsonString);

import 'dart:convert';

List<MyRequestFundModel> myRequestFundModelFromJson(String str) => List<MyRequestFundModel>.from(json.decode(str).map((x) => MyRequestFundModel.fromJson(x)));

String myRequestFundModelToJson(List<MyRequestFundModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyRequestFundModel {
  int id;
  int userId;
  int fundingEntityId;
  String amount;
  String status;
  dynamic note;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  Entity entity;

  MyRequestFundModel({
    required this.id,
    required this.userId,
    required this.fundingEntityId,
    required this.amount,
    required this.status,
    required this.note,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.entity,
  });

  factory MyRequestFundModel.fromJson(Map<String, dynamic> json) => MyRequestFundModel(
    id: json["id"],
    userId: json["user_id"],
    fundingEntityId: json["funding_entity_id"],
    amount: json["amount"],
    status: json["status"],
    note: json["note"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    entity: Entity.fromJson(json["entity"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "funding_entity_id": fundingEntityId,
    "amount": amount,
    "status": status,
    "note": note,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "entity": entity.toJson(),
  };
}

class Entity {
  int id;
  String name;
  String? picture;

  Entity({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
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
