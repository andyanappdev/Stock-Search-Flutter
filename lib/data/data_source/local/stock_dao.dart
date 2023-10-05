import 'package:hive_flutter/hive_flutter.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';
import 'package:us_stock/data/data_source/local/favorite_entity.dart';

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
  Future<CompanyEntity> updateCompanyEntity(CompanyEntity selectedObject) async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    final List<CompanyEntity> companyList = box.values.toList();
    final updateObject = companyList.singleWhere((e) => e.symbol == selectedObject.symbol);
    updateObject.favorite = !updateObject.favorite;
    await updateObject.save();
    return updateObject;
  }

  /// stock.db Delete (삭제)
  Future<void> clearCompanyList() async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    await box.clear();
  }

  /// favorite.db Create or Delete
  Future<void> handleFavoriteCompanyList(CompanyEntity updateObject) async {
    final favoriteBox =
        await Hive.openBox<FavoriteEntity>('favorite.db');
    final favoriteEntity = favoriteBox.get(0);
    if (favoriteEntity == null) {
      final newFavoriteEntity = FavoriteEntity();
      await favoriteBox.put(0, newFavoriteEntity);
    }
    final favoriteCompanyList = favoriteEntity!.favoriteCompanyList;
    if (updateObject.favorite) {
      favoriteCompanyList.add(updateObject);
      favoriteEntity.updateTime = DateTime.now();
      await favoriteEntity.save();
    } else {
      favoriteCompanyList.removeWhere((e) => e.symbol == updateObject.symbol);
      favoriteEntity.updateTime = DateTime.now();
      await favoriteEntity.save();
    }
  }

  /// favorite.db Read
  Future<FavoriteEntity> readFavoriteEntity() async {
    final favoriteBox = await Hive.openBox<FavoriteEntity>('favorite.db');
    final favoriteEntity = favoriteBox.get(0);
    if (favoriteEntity == null) {
      final newFavoriteEntity = FavoriteEntity();
      await favoriteBox.put(0, newFavoriteEntity);
    }
    return favoriteEntity!;
  }
}