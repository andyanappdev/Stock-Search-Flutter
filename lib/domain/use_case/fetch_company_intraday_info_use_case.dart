import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class FetchCompanyIntradayInfoUseCase {
  final StockRepository _repository;

  FetchCompanyIntradayInfoUseCase(this._repository);

  Future<Result<List<CompanyIntradayInfo>>> execute(String symbol) async {
    try {
      final result = await _repository.fetchCompanyIntradayInfo(symbol);
      return Result.success(result);
    } catch (e) {
      return Result.error('ErrorFetchCompanyIntradayInfoUseCase: ${e.toString()}');
    }
  }
}