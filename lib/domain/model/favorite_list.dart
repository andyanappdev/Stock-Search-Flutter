import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:us_stock/domain/model/corporation_list.dart';
import 'package:flutter/foundation.dart';

part 'favorite_list.freezed.dart';

part 'favorite_list.g.dart';

@freezed
class FavoriteList with _$FavoriteList {
  const factory FavoriteList({
    @Default([]) List<CorporationList> favoriteList,
  }) = _FavoriteList;

  factory FavoriteList.fromJson(Map<String, Object?> json) =>
      _$FavoriteListFromJson(json);
}
