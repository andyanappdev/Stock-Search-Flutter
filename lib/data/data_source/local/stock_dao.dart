import 'package:hive_flutter/hive_flutter.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';

/// Local DB (Hive)에 접근하는 DAO
class StockDao {
  /// stock.db Create (추가)
  Future<void> insertCompanyList(List<CompanyEntity> companyEntities) async {
    // box open ('stock.db 이름을 가진 Hive Box(DB)를 사용하기 위해 open)
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    await box.addAll(companyEntities);
  }

  /// stock.db 내의 data Search
  Future<List<CompanyEntity>> searchCompany(String query) async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    final List<CompanyEntity> companyList = box.values.toList();
    return companyList
        .where((e) =>
    e.name.toLowerCase().contains(query.toLowerCase()) ||
        e.symbol == query.toUpperCase())
        .toList();
  }

  /// stock.db Update
  // 해당 object의 키를 전달 하여 업데이트 하는 방법을 테스트해보자
  Future<void> updateCompanyEntity(int index) async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    final List<CompanyEntity> companyList = box.values.toList();
    final updateObject = companyList[index];
    updateObject.favorite = !updateObject.favorite;
    await updateObject.save();
  }

  /// stock.db Delete (삭제)
  Future<void> clearCompanyList() async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    await box.clear();
  }

  /// favorite.db Create or Delete
  Future<void> insertFavoriteList(CompanyEntity favoriteCompany) async {
    final favoriteBox =
        await Hive.openBox<CompanyEntity>('favorite.db');
    if (favoriteCompany.favorite) {
      await favoriteBox.add(favoriteCompany);
    } else {
      await favoriteBox.delete(favoriteCompany.key);
    }
  }

  /// favorite.db Read
  Future<List<CompanyEntity>> readFavoriteCompanyList() async {
    final favoriteBox = await Hive.openBox<CompanyEntity>('favorite.db');
    return favoriteBox.values.toList();
  }
}