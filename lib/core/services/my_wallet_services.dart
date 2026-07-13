import 'dart:convert';
import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/models/funding_entity_model.dart';
import 'package:borsa_now_bis/core/models/my_request_fund_model.dart';
import 'package:dio/dio.dart';

import '../models/chart_sales_model.dart';

class MyWalletServices {
  final Dio dio;

  MyWalletServices({required this.dio});

  Future<Map<String, dynamic>> getMyWalletDashboard() async {
    try {
      final response = await dio.get(
        "/api/v1/investor/wallet/${getLang()}",
      );

      return response.data['data'];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> withdrawRequest(Map<String, dynamic> params) async {
    try {
      final response = await dio.post(
        "/api/v1/investor/wallet/request/withdraw/add/${getLang()}",
        data: params,
      );
      return response.data['data'];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> addFundRequest(Map<String, dynamic> params) async {
    try {
      final response = await dio.post(
        "/api/v1/investor/funding/request/add/${getLang()}",
        data: params,
      );
      return response.data['data'];
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<ChartSalesModel>> getStats(String year, String month) async {
    try {
      final response = await dio.get(
        "/api/v1/investor/wallet/revenues/${getLang()}",
        queryParameters: {"year": year, "month": month},
      );
      print("Response chart ${response.data}");
      return charSalesModelFromJson(jsonEncode(response.data['data']));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<FundingEntityModel>> getFundingEntities() async {
    try {
      final response = await dio.get(
        "/api/v1/general/funding/entities/${getLang()}",
      );
      return fundingEntityModelFromJson(jsonEncode(response.data['data']));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<MyRequestFundModel>> getMyFundRequests(int page) async {
    try {
      final response = await dio.get(
        "/api/v1/investor/funding/request/list/${getLang()}?page=$page",
      );
      return myRequestFundModelFromJson(jsonEncode(response.data['data']['data']));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
