import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class UpdateFavoriteUseCase {
  final StockRepository _repository;

  UpdateFavoriteUseCase(this._repository);

  Future<void> execute(Company selectedObject) async {
      await _repository.updateCompay(selectedObject);
  }

  // Future<Result<List<Company>>> execute(int index) async {
  //   try {
  //     await _repository.updateCompay(index);
  //     final result = await _repository.fetchCompanyList(false, '');
  //     return Result.success(result);
  //   } catch (e) {
  //     return Result.error('Error UpdateFavoriteUseCase: ${e.toString()}');
  //   }
  // }


}