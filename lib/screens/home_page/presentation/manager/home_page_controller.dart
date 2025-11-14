import 'package:borsa_now_bis/core/services/home_page_service.dart';

import '../../data/models/deal_product_model.dart';

class HomePageController {

  final HomePageService _homePageService;

  HomePageController(this._homePageService);

  Future<List<DealProductModel>> getDealProducts(int pageKey) async {
    return await _homePageService.getDealProducts(pageKey);
  }
}