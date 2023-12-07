import 'package:us_stock/data/data_source/local/company_entity.dart';
import 'package:us_stock/domain/model/company.dart';

extension ToCompany on CompanyEntity {
  Company toCompanyList() {
    return Company(
      symbol: symbol,
      name: name,
      exchange: exchange,
      assetType: assetType,
      ipoDate: DateTime.parse(ipoDate),
      status: status,
      favorite: favorite,
    );
  }
}

extension ToCompanyEntity on Company {
  CompanyEntity toCompanyEntity() {
    return CompanyEntity(
      symbol: symbol,
      name: name,
      exchange: exchange,
      assetType: assetType,
      ipoDate: ipoDate.toString(),
      status: status,
      favorite: favorite,
    );
  }
}
