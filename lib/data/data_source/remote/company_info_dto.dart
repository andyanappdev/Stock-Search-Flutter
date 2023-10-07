import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company_info_dto.freezed.dart';

part 'company_info_dto.g.dart';

@freezed
class CompanyInfoDto with _$CompanyInfoDto {
  const factory CompanyInfoDto({
    @JsonKey(name: 'Symbol') String? symbol,
    @JsonKey(name: 'AssetType') String? assetType,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Address') String? address,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Exchange') String? exchange,
    @JsonKey(name: 'Currency') String? currency,
    @JsonKey(name: 'Country') String? country,
    @JsonKey(name: 'Sector') String? sector,
    @JsonKey(name: 'Industry') String? industry,
    @JsonKey(name: 'MarketCapitalization') String? marketCapitalization,
    @JsonKey(name: 'PERatio') String? per,
    @JsonKey(name: 'EPS') String? eps,
    @JsonKey(name: '52WeekHigh') String? weekHigh,
    @JsonKey(name: '52WeekLow') String? weekLow,
  }) = _CompanyInfoDto;

  factory CompanyInfoDto.fromJson(Map<String, Object?> json) => _$CompanyInfoDtoFromJson(json);
}