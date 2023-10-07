import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company_info.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class FetchCompanyInfoUseCase {
  final StockRepository _repository;

  FetchCompanyInfoUseCase(this._repository);

  Future<Result<CompanyInfo>> execute(String symbol) async {
    try {
      final result = await _repository.fetchCompanyInfo(symbol);
      return Result.success(result);
    } catch (e) {
      return Result.error('Error FetchCompanyInfoUseCase: ${e.toString()}');
    }
  }
}