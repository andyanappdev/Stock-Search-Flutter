import 'package:us_stock/data/data_source/local/corporation_list_entity.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

extension ToCorporationList on CorporationListEntity {
  CorporationList toCorporationList() {
    return CorporationList(
      symbol: symbol,
      name: name,
      exchange: exchange,
      assetType: assetType,
      ipoDate: DateTime.parse(ipoDate),
      status: status,
      favorite: favorite,
    );
  }
}

extension ToCorporationListEntity on CorporationList {
  CorporationListEntity toCorporationListEntity() {
    return CorporationListEntity(
      symbol: symbol,
      name: name,
      exchange: exchange,
      assetType: assetType,
      ipoDate: ipoDate.toString(),
      status: status,
      favorite: favorite,
    );
  }
}
