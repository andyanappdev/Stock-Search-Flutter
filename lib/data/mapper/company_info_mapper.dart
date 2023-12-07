import 'package:us_stock/data/data_source/remote/company_info_dto.dart';
import 'package:us_stock/domain/model/company_info.dart';

extension ToCompanyInfo on CompanyInfoDto {
  CompanyInfo toCompanyInfo() {
    return CompanyInfo(
      symbol: symbol ?? '',
      assetType: assetType ?? '',
      name: name ?? '',
      description: description ?? '',
      address: address ?? '',
      exchange: exchange ?? '',
      currency: currency ?? '',
      country: country ?? '',
      sector: sector ?? '',
      industry: industry ?? '',
      marketCapitalization: marketCapitalization ?? '',
      per: per ?? '',
      eps: eps ?? '',
      profitMargin: profitMargin ?? '',
      dividendYield: dividendYield ?? '',
      priceToBookRatio: priceToBookRatio ?? '',
      beta: beta ?? '',
      weekHigh: weekHigh ?? '',
      weekLow: weekLow ?? '',
    );
  }
}