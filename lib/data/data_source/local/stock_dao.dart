import 'package:hive_flutter/hive_flutter.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';

/// Local DB (Hive)에 접근하는 DAO
class StockDao {
  /// Hive에 추가
  Future<void> insertCompanyList(List<CompanyEntity> companyEntities) async {
    // box open ('stock.db 이름을 가진 Hive Box(DB)를 사용하기 위해 open)
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    await box.addAll(companyEntities);
  }

  /// Hive에 저장된 data Clear
  Future<void> clearCompanyList() async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    await box.clear();
  }

  /// Hive 내의 favorite property update
  Future<void> updateCompanyEntity(int index) async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    final List<CompanyEntity> companyList = box.values.toList();
    final updateObject = companyList[index];
    updateObject.favorite = !updateObject.favorite;
    updateObject.save();
  }

  /// Hive 내의 data Search
  Future<List<CompanyEntity>> searchCompany(String query) async {
    final box = await Hive.openBox<CompanyEntity>('stock.db');
    final List<CompanyEntity> companyList = box.values.toList();
    return companyList
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            e.symbol == query.toUpperCase())
        .toList();
  }
}
