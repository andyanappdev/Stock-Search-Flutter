import 'package:hive_flutter/hive_flutter.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';

part 'favorite_entity.g.dart';

/// Hive에 저장될 Entity class (객체로 저장할 데이터)
@HiveType(typeId: 1)
class FavoriteEntity extends HiveObject {
  @HiveField(0)
  List<CompanyEntity> favoriteCompanyList;
  DateTime updateTime;

  FavoriteEntity({List<CompanyEntity>? favoriteCompanyList, DateTime? updateTime}) : favoriteCompanyList = favoriteCompanyList ?? [], updateTime = updateTime ?? DateTime.now();
}