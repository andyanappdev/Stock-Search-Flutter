import 'package:us_stock/domain/model/company_info.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';

abstract interface class StockRepository {
  Future<List<Company>> fetchCompanyList(bool fetchFromRemote, String query);

  Future<List<Company>> fetchFavoriteCompanyList();

  Future<CompanyInfo> fetchCompanyInfo(String symbol);

  Future<List<CompanyIntradayInfo>> fetchCompanyIntradayInfo(String symbol);

  Future<void> combineList(List<Company> updatedCompanyList);

  Future<void> updateCompay(Company selectedObject);

  Future<void> updatedFavoriteList(Company selectedObject);
}