import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company.freezed.dart';

part 'company.g.dart';

@freezed
class Company with _$Company {
  const factory Company({
    required String symbol,
    required String name,
    required String exchange,
    required String assetType,
    required DateTime ipoDate,
    required String status,
    @Default(false) bool favorite,
  }) = _Company;

  factory Company.fromJson(Map<String, Object?> json) =>
      _$CompanyFromJson(json);
}
