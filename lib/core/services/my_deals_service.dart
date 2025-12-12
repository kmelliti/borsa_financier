import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:dio/dio.dart';

import '../../screens/home_page/data/models/deal_product_model.dart';
import '../../screens/my_deals/data/models/subscribed_deal_model.dart';

class MyDealsService {
  final Dio _dio;

  MyDealsService(this._dio);

  Future<List<SubscribedDealModel>> getMyDeals(int pageKey,Map<String, dynamic>? value) async {
    // if(value != null){
    //   pageKey = 1;
    // }
    log("params filter ${value}");

    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/deals/subscribed/${getLang()}?page=$pageKey",queryParameters: value);
      log("response filters for ${pageKey} ${(response.data['data']['data'] as List).length}");
      return (response.data['data']['data'] as List).map((e) => SubscribedDealModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<Map<String,dynamic>> getDashboard()async {
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/dashboard/${getLang()}");
      return response.data['data'];
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }
}