import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company_intraday_info_dto.freezed.dart';

part 'company_intraday_info_dto.g.dart';

@freezed
class CompanyIntradayInfoDto with _$CompanyIntradayInfoDto {
  const factory CompanyIntradayInfoDto({
    String? timestamp,
    num? open,
    num? high,
    num? low,
    num? close,
    num? volume,
  }) = _CompanyIntradayInfoDto;

  factory CompanyIntradayInfoDto.fromJson(Map<String, Object?> json) => _$CompanyIntradayInfoDtoFromJson(json);
}
