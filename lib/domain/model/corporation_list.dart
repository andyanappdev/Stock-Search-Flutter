import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'corporation_list.freezed.dart';

part 'corporation_list.g.dart';

@freezed
class CorporationList with _$CorporationList {
  const factory CorporationList({
    required String symbol,
    required String name,
    required String exchange,
    required String assetType,
    required DateTime ipoDate,
    required String status,
  }) = _CorporationList;

  factory CorporationList.fromJson(Map<String, Object?> json) =>
      _$CorporationListFromJson(json);
}
