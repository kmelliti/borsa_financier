// To parse this JSON data, do
//
//     final subscribedDealModel = subscribedDealModelFromJson(jsonString);

import 'dart:convert';

List<SubscribedDealModel> subscribedDealModelFromJson(String str) => List<SubscribedDealModel>.from(json.decode(str).map((x) => SubscribedDealModel.fromJson(x)));

String subscribedDealModelToJson(List<SubscribedDealModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscribedDealModel {
  int id;
  int wholesaleOfferId;
  int investorId;
  String transactionId;
  int quantityPurchased;
  String amountInvested;
  String stakePercentage;
  String expectedProfit;
  String actualProfit;
  String status;
  int isDeleted;
  dynamic deletedAt;
  int createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  Deal deal;

  SubscribedDealModel({
    required this.id,
    required this.wholesaleOfferId,
    required this.investorId,
    required this.transactionId,
    required this.quantityPurchased,
    required this.amountInvested,
    required this.stakePercentage,
    required this.expectedProfit,
    required this.actualProfit,
    required this.status,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.deal,
  });

  factory SubscribedDealModel.fromJson(Map<String, dynamic> json) => SubscribedDealModel(
    id: json["id"],
    wholesaleOfferId: json["wholesale_offer_id"],
    investorId: json["investor_id"],
    transactionId: json["transaction_id"],
    quantityPurchased: json["quantity_purchased"],
    amountInvested: json["amount_invested"],
    stakePercentage: json["stake_percentage"],
    expectedProfit: json["expected_profit"],
    actualProfit: json["actual_profit"],
    status: json["status"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deal: Deal.fromJson(json["deal"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "wholesale_offer_id": wholesaleOfferId,
    "investor_id": investorId,
    "transaction_id": transactionId,
    "quantity_purchased": quantityPurchased,
    "amount_invested": amountInvested,
    "stake_percentage": stakePercentage,
    "expected_profit": expectedProfit,
    "actual_profit": actualProfit,
    "status": status,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deal": deal.toJson(),
  };
}

class Deal {
  int id;
  int merchantId;
  int productId;
  int quantity;
  String storePrice;
  String wholesalePrice;
  String retailPrice;
  String minInvestment;
  int quantitySold;
  String totalInvested;
  String targetAmount;
  String status;
  dynamic offerStartAt;
  dynamic offerEndAt;
  int isDeleted;
  dynamic deletedAt;
  int createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  Product product;

  Deal({
    required this.id,
    required this.merchantId,
    required this.productId,
    required this.quantity,
    required this.storePrice,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.minInvestment,
    required this.quantitySold,
    required this.totalInvested,
    required this.targetAmount,
    required this.status,
    required this.offerStartAt,
    required this.offerEndAt,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
    id: json["id"],
    merchantId: json["merchant_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    storePrice: json["store_price"],
    wholesalePrice: json["wholesale_price"],
    retailPrice: json["retail_price"],
    minInvestment: json["min_investment"],
    quantitySold: json["quantity_sold"],
    totalInvested: json["total_invested"],
    targetAmount: json["target_amount"],
    status: json["status"],
    offerStartAt: json["offer_start_at"],
    offerEndAt: json["offer_end_at"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "product_id": productId,
    "quantity": quantity,
    "store_price": storePrice,
    "wholesale_price": wholesalePrice,
    "retail_price": retailPrice,
    "min_investment": minInvestment,
    "quantity_sold": quantitySold,
    "total_invested": totalInvested,
    "target_amount": targetAmount,
    "status": status,
    "offer_start_at": offerStartAt,
    "offer_end_at": offerEndAt,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product": product.toJson(),
  };
}

class Product {
  int id;
  int merchantId;
  int productCategorieId;
  String sku;
  String name;
  String description;
  String costBasis;
  int isDeleted;
  dynamic deletedAt;
  int createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime createdAt;
  DateTime updatedAt;
  List<ProductPicture> productPictures;

  Product({
    required this.id,
    required this.merchantId,
    required this.productCategorieId,
    required this.sku,
    required this.name,
    required this.description,
    required this.costBasis,
    required this.isDeleted,
    required this.deletedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.productPictures,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    merchantId: json["merchant_id"],
    productCategorieId: json["product_categorie_id"],
    sku: json["sku"],
    name: json["name"],
    description: json["description"],
    costBasis: json["cost_basis"],
    isDeleted: json["is_deleted"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productPictures: List<ProductPicture>.from(json["product_pictures"].map((x) => ProductPicture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "product_categorie_id": productCategorieId,
    "sku": sku,
    "name": name,
    "description": description,
    "cost_basis": costBasis,
    "is_deleted": isDeleted,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_pictures": List<dynamic>.from(productPictures.map((x) => x.toJson())),
  };
}

class ProductPicture {
  int id;
  int productId;
  String picture;
  DateTime createdAt;
  DateTime updatedAt;

  ProductPicture({
    required this.id,
    required this.productId,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductPicture.fromJson(Map<String, dynamic> json) => ProductPicture(
    id: json["id"],
    productId: json["product_id"],
    picture: json["picture"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "picture": picture,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
