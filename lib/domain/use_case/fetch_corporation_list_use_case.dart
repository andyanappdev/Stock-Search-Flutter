import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/corporation_list.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class FetchCorporationListUseCase {
  final StockRepository _repository;

  FetchCorporationListUseCase(this._repository);

  Future<Result<List<CorporationList>>> execute(
      bool fetchFromRemote, String query) async {
    try {
      final result =
          await _repository.fetchCorporationList(fetchFromRemote, query);
      return Result.success(result);
    } catch (e) {
      return Result.error(
          'Error FetchCorporationListUseCase fetchCorporationList: ${e.toString()}');
    }
  }
}
