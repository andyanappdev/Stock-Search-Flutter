import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:flutter/foundation.dart';

part 'favorite_company_list.freezed.dart';

part 'favorite_company_list.g.dart';

@freezed
class FavoriteCompanyList with _$FavoriteCompanyList {
  const factory FavoriteCompanyList({
    @Default([]) List<Company> favoriteCompanyList,
  }) = _FavoriteCompanyList;

  factory FavoriteCompanyList.fromJson(Map<String, Object?> json) =>
      _$FavoriteCompanyListFromJson(json);
}
