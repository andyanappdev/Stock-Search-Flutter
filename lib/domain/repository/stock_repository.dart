import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/corporation_info.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

abstract interface class StockRepository {
  Future<Result<List<CorporationList>>> fetchCorporationList(
      bool fetchFromRemote, String query);

  Future<Result<CorporationInfo>> fetchCorporationInfo(String symbol);
}
