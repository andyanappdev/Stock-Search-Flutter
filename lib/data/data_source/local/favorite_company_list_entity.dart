import 'package:hive/hive.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';
import 'package:us_stock/domain/model/company.dart';

part 'favorite_company_list_entity.g.dart';

/// Hive에 저장될 Entity class (객체로 저장할 데이터)

@HiveType(typeId: 1)
class FavoriteCompanyListEntity {
  @HiveField(0, defaultValue: [])
  List<CompanyEntity> favoriteCompanyList;

  FavoriteCompanyListEntity({List<Company>? favoriteCompanyList})
      : favoriteCompanyList = [];
}
