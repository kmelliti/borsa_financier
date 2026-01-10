import 'dart:convert';

List<ChartSalesModel> charSalesModelFromJson(String str) => List<ChartSalesModel>.from(json.decode(str).map((x) => ChartSalesModel.fromJson(x)));

String charSalesModelToJson(List<ChartSalesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChartSalesModel {
  int month;
  String total;

  ChartSalesModel({
    required this.month,
    required this.total,
  });

  factory ChartSalesModel.fromJson(Map<String, dynamic> json) => ChartSalesModel(
    month: json["month"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "total": total,
  };
}
