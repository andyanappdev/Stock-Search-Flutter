import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class FetchCompanyListUseCase {
  final StockRepository _repository;

  FetchCompanyListUseCase(this._repository);

  Future<Result<List<Company>>> execute(
      bool fetchFromRemote, String query) async {
    try {
      final result = await _repository.fetchCompanyList(fetchFromRemote, query);
      return Result.success(result);
    } catch (e) {
      return Result.error(
          'Error FetchCompanyListUseCase fetchCorporationList: ${e.toString()}');
    }
  }
}
