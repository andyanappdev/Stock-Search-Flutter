import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company_intraday_info.freezed.dart';

part 'company_intraday_info.g.dart';

@freezed
class CompanyIntradayInfo with _$CompanyIntradayInfo {
  const factory CompanyIntradayInfo({
    required DateTime timeStamp,
    required double open,
    required double high,
    required double low,
    required double close,
    required int volume,
  }) = _CompanyIntradayInfo;

  factory CompanyIntradayInfo.fromJson(Map<String, Object?> json) => _$CompanyIntradayInfoFromJson(json);
}
