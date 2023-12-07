import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:us_stock/domain/model/company_info.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';

part 'detail_state.freezed.dart';

part 'detail_state.g.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState({
    CompanyInfo? companyInfo,
    @Default(false) bool isLoading,
    @Default([]) List<CompanyIntradayInfo> companyIntradayInfo,
  }) = _DetailState;

  factory DetailState.fromJson(Map<String, Object?> json) => _$DetailStateFromJson(json);
}
