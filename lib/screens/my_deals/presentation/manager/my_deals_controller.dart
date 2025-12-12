import '../../../../core/services/my_deals_service.dart';
import '../../../home_page/data/models/deal_product_model.dart';
import '../../data/models/subscribed_deal_model.dart';

class MyDealsController  {

  final MyDealsService myDealsService;

  MyDealsController(this.myDealsService);

  Future<List<SubscribedDealModel>> getMyDeals(int pageKey,Map<String, dynamic>? value) async {
    return await myDealsService.getMyDeals(pageKey,value);
  }

  Future<Map<String,dynamic>> getDashboard()async {
    return await myDealsService.getDashboard();
  }
}