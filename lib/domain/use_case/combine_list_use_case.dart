import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class CombineListUseCase {
  final StockRepository _repository;

  CombineListUseCase(this._repository);

  Future<void> execute(List<Company> updatedCompanyList) async {
    await _repository.combineList(updatedCompanyList);
  }
}