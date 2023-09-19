import 'package:us_stock/domain/model/corporation_info.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

abstract interface class StockRepository {
  Future<List<CorporationList>> fetchCorporationList(
      bool fetchFromRemote, String query);

  Future<CorporationInfo> fetchCorporationInfo(String symbol);
}
