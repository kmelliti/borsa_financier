import 'dart:convert';
import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:dio/dio.dart';

import '../models/chart_sales_model.dart';

class MyWalletServices {

  final Dio dio;

  MyWalletServices({required this.dio});


  Future<Map<String,dynamic>> getMyWalletDashboard() async {
    try {
      final response = await dio.get("/BorsaNow/public/api/v1/investor/wallet/${getLang()}");
      return response.data['data'];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> withdrawRequest(Map<String,dynamic> params )async {
    try {
      final response = await dio.post("/BorsaNow/public/api/v1/investor/wallet/request/withdraw/add/${getLang()}",data: params);
      return response.data['data'];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<ChartSalesModel>> getStats(String year, String month) async {
    try {
      final response = await dio.get("/BorsaNow/public/api/v1/investor/wallet/revenues/${getLang()}",queryParameters: {
        "year":year,
        "month":month

      });
      return charSalesModelFromJson(jsonEncode(response.data['data']));
    } catch (e) {
      log(e.toString());
      rethrow;
    }

  }
}