import 'package:hive/hive.dart';

part 'corporation_list_entity.g.dart';

/// Hive에 저장될 Entity class (객체로 저장할 데이터)
@HiveType(typeId: 0)
class CorporationListEntity extends HiveObject {
  @HiveField(0)
  String symbol;
  @HiveField(1)
  String name;
  @HiveField(2)
  String exchange;
  @HiveField(3)
  String assetType;
  @HiveField(4)
  String ipoDate;
  @HiveField(5)
  String status;
  @HiveField(6, defaultValue: false)
  bool favorite;

  CorporationListEntity({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.assetType,
    required this.ipoDate,
    required this.status,
    this.favorite = false,
  });
}
