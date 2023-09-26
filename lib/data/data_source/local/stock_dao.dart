import 'package:hive_flutter/hive_flutter.dart';
import 'package:us_stock/data/data_source/local/corporation_list_entity.dart';

/// Local DB (Hive)에 접근하는 DAO
class StockDao {
  /// Hive에 추가
  Future<void> insertCorporationList(
      List<CorporationListEntity> corporationListEntities) async {
    // box open ('stock.db 이름을 가진 Hive Box(DB)를 사용하기 위해 open)
    final box = await Hive.openBox<CorporationListEntity>('stock.db');
    await box.addAll(corporationListEntities);
  }

  /// Hive에 저장된 data Clear
  Future<void> clearCorporationList() async {
    final box = await Hive.openBox<CorporationListEntity>('stock.db');
    await box.clear();
  }

  /// Hive 내의 favorite property update
  Future<void> updateCorporationListEntity(int index) async {
    final box = await Hive.openBox<CorporationListEntity>('stock.db');
    final List<CorporationListEntity> corporationList = box.values.toList();
    final updateObject = corporationList[index];
    updateObject.favorite = !updateObject.favorite;
  }

  /// Hive 내의 data Search
  Future<List<CorporationListEntity>> searchCorporation(String query) async {
    final box = await Hive.openBox<CorporationListEntity>('stock.db');
    final List<CorporationListEntity> corporationList = box.values.toList();
    return corporationList
        .where((e) =>
            e.name.toLowerCase().contains(query.toLowerCase()) ||
            e.symbol == query.toUpperCase())
        .toList();
  }
}
