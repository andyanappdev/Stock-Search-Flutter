import 'package:hive/hive.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

part 'favorite_list_entity.g.dart';

/// Hive에 저장될 Entity class (객체로 저장할 데이터)

@HiveType(typeId: 1)
class FavoriteListEntity {
  @HiveField(0, defaultValue: [])
  List<CorporationList> favoriteList;

  FavoriteListEntity({List<CorporationList>? favoriteList}) : favoriteList = [];
}
