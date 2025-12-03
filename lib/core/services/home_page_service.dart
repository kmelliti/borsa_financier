import 'dart:developer';

import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/screens/home_page/data/models/review_response_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../screens/home_page/data/models/deal_product_model.dart';
import '../exception/api_exception.dart';

class HomePageService {
  final Dio _dio;
  HomePageService(this._dio);

  Future<List<DealProductModel>> getDealProducts(int pageKey, Map<String, dynamic>? value) async {
    int page = pageKey;
    if(value != null){
      page = 1;
    }
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/deals/${getLang()}?page=$page",queryParameters: value);
      log("response filters for ${value} page key ${pageKey} ${response.data}");
      return (response.data['data']['data'] as List).map((e) => DealProductModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }  Future<List<DealProductModel>> getRelatedDeals(int dealId) async {
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/deals/${getLang()}?id=$dealId");
      return (response.data['data']['data'] as List).map((e) => DealProductModel.fromJson(e)).toList();
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }

  Future<ReviewResponseModel> getReviews(String productId) async {
    try {
      final response = await _dio.get("/BorsaNow/public/api/v1/investor/products/rates/${getLang()}",queryParameters: {
        "product_id":productId
      });
      log("${response.data}");
      return ReviewResponseModel.fromJson(response.data['data']);
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }
  Future<ReviewModel> addReview (List<String?> images , Map<String,dynamic> params) async {
    try {
      final response = await _dio.post("/BorsaNow/public/api/v1/investor/products/rate/add/${getLang()}",data: params);
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      log("${response.data}");
      return ReviewModel.fromJson(response.data['data']);
    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }
  Future<void> addDeleteFav ( Map<String,dynamic> params) async {
    try {
      final response = await _dio.post("/BorsaNow/public/api/v1/investor/deal/favorite/toggle/${getLang()}",data: params);
      if (response.data["result"] == false) {
        throw ApiException(response.data["message"]);
      }
      log("${response.data}");

    } catch (e, s) {
      log("$e $s");
      throw e;
    }
  }


}