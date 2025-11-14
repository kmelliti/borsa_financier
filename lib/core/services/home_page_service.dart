import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:dio/dio.dart';

import '../../screens/home_page/data/models/deal_product_model.dart';

class HomePageService {
  final Dio _dio;
  HomePageService(this._dio);

  Future<List<DealProductModel>> getDealProducts(int pageKey) async {
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/deals/${getLang()}?page=$pageKey");
      return (response.data['data']['data'] as List).map((e) => DealProductModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }
}