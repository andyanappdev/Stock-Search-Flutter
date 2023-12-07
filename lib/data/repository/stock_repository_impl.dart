import 'dart:convert';

import 'package:us_stock/data/csv/company_intraday_info_parser.dart';
import 'package:us_stock/data/csv/company_list_parser.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';
import 'package:us_stock/data/data_source/local/stock_dao.dart';
import 'package:us_stock/data/data_source/remote/company_info_dto.dart';
import 'package:us_stock/data/data_source/remote/stock_api.dart';
import 'package:us_stock/data/mapper/company_info_mapper.dart';
import 'package:us_stock/data/mapper/company_mapper.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/model/company_info.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final CompanyListParser _companyListParser = CompanyListParser();
  final CompanyIntradayInfoParser _companyIntradayInfoParser = CompanyIntradayInfoParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<List<Company>> fetchCompanyList(
      bool fetchFromRemote, String query) async {
    // 1. cache에서 데이터 찾기
    final List<CompanyEntity> localList = await _dao.searchCompany(query);
    // 2. cache에 데이터가 없다면 remote에서 가져 온다
    final isDbEmpty = localList.isEmpty && query.isEmpty;
    // 조건
    final shouldLoadFromCache = !isDbEmpty && !fetchFromRemote;
    // cache에서 가져오기
    if (shouldLoadFromCache) {
      return localList.map((e) => e.toCompanyList()).toList();
    }
    // remote에서 가져오기
    try {
      final response = await _api.fetchStocksList();
      final remoteList = await _companyListParser.parse(response.body);
      // 기존에 있던 cache 비워주기 (clear 작업이 없으면 계속해서 뒤에 add 되기 때문)
      await _dao.clearCompanyList();
      // 새로 remote 에서 받아온 data cache에 추가
      await _dao.insertCompanyList(
          remoteList.map((e) => e.toCompanyEntity()).toList());
      return remoteList;
    } catch (e) {
      throw Exception(
          'Error StockRepositoryImpl fetchCorporationList: ${e.toString()}');
    }
  }

  @override
  Future<List<Company>> fetchFavoriteCompanyList() async {
    final favoriteEntity = await _dao.readFavoriteEntity();
    if (favoriteEntity.favoriteCompanyList.isNotEmpty) {
      return favoriteEntity.favoriteCompanyList.map((e) => e.toCompanyList()).toList();
    } else {
      return [];
    }
  }

  @override
  Future<CompanyInfo> fetchCompanyInfo(String symbol) async {
    try {
      final response = await _api.fetchCompanyInfo(symbol: symbol);
      final companyInfoDto = CompanyInfoDto.fromJson(jsonDecode(response.body));
      return companyInfoDto.toCompanyInfo();
    } catch (e) {
      throw Exception('Error StockRepositoryImpl fetchCompanyInfo: ${e.toString()}');
    }
  }

  @override
  Future<List<CompanyIntradayInfo>> fetchCompanyIntradayInfo(String symbol) async {
    try {
      final response = await _api.fetchCompanyIntradayInfo(symbol: symbol);
      final result = await _companyIntradayInfoParser.parse(response.body);
      return result;
    } catch (e) {
      throw Exception('Error StockRepositoryImpl fetchCompanyIntradayInfo: ${e.toString()}');
    }
  }

  @override
  Future<void> combineList(List<Company> updatedCompanyList) async {
    await _dao.clearCompanyList();
    await _dao.insertCompanyList(updatedCompanyList.map((e) => e.toCompanyEntity()).toList());
  }

  @override
  Future<void> updateCompay(Company selectedObject) async {
    final updateObject = selectedObject.toCompanyEntity();
    updateObject.favorite = !selectedObject.favorite;
    await _dao.updateCompanyEntity(updateObject);
  }

  @override
  Future<void> updatedFavoriteList(Company selectedObject) async {
    final updateObject = selectedObject.toCompanyEntity();
    updateObject.favorite = !selectedObject.favorite;
    await _dao.handleFavoriteCompanyList(updateObject);
  }
}