import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class FetchFavoriteCompanyListUseCase {
  final StockRepository _repository;

  FetchFavoriteCompanyListUseCase(this._repository);

  Future<Result<List<Company>>> execute() async {
    try {
      final result = await _repository.fetchFavoriteCompanyList();
      return Result.success(result);
    } catch (e) {
      return Result.error('Error FetchFavoriteCompanyListUseCase: ${e.toString()}');
    }
  }
}