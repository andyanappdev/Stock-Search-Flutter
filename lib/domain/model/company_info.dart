import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'company_info.freezed.dart';

part 'company_info.g.dart';

@freezed
class CompanyInfo with _$CompanyInfo {
  const factory CompanyInfo({
    required String symbol,
    required String assetType,
    required String name,
    required String description,
    // required String cik,  // Central Index Key, 미국, 용도 : SEC에 보고서를 제출하는 회사를 식별하기 위해 사용하는 번호
    required String address,
    required String exchange,
    required String currency,
    required String country,
    required String sector,
    required String industry,
    // required String fiscalYearEnd,
    // required DateTime latestQuarter,
    required String marketCapitalization, // 시가총액
    // required String ebitda,  // 상각전영업이익 Earings: 기업이익, Interst: 이자, Taxes: 법인세, Depreciation and Amortization: 감가상각비
    required String per, // 주가수익비율
    // required String pegRatio,  // 주가이익증가비율
    // required String bookValue,  // 자기자본총액
    // required String dividendPerShare,  // 주당 배당금
    // required String dividendYield,
    required String eps, // 주당순이익
    // required String revenuePerShareTtm,
    // required String profitMargin,
    // required String operatingMarginTtm,
    // required String returnOnAssetsTtm,
    // required String returnOnEquityTtm,
    // required String revenueTtm,
    // required String grossProfitTtm,
    // required String dilutedEpsttm,
    // required String quarterlyEarningsGrowthYoy,
    // required String quarterlyRevenueGrowthYoy,
    // required String analystTargetPrice,
    // required String trailingPe,
    // required String forwardPe,
    // required String priceToSalesRatioTtm,
    // required String priceToBookRatio,
    // required String evToRevenue,
    // required String evToEbitda,
    // required String beta,
    required String weekHigh,
    required String weekLow,
    // required String the50DayMovingAverage,
    // required String the200DayMovingAverage,
    // required String sharesOutstanding,
    // required DateTime dividendDate,
    // required DateTime exDividendDate,
  }) = _CompanyInfo;

  factory CompanyInfo.fromJson(Map<String, Object?> json) =>
      _$CompanyInfoFromJson(json);
}
