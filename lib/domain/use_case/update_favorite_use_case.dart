import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class UpdateFavoriteUseCase {
  final StockRepository _repository;

  UpdateFavoriteUseCase(this._repository);

  Future<void> execute(Company selectedObject) async {
      await _repository.updateCompay(selectedObject);
      await _repository.updatedFavoriteList(selectedObject);
  }
}