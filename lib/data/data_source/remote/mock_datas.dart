import 'dart:convert';

import 'package:flutter/services.dart';
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

class MockStockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final CompanyListParser _companyListParser = CompanyListParser();
  final CompanyIntradayInfoParser _companyIntradayInfoParser = CompanyIntradayInfoParser();

  MockStockRepositoryImpl(this._api, this._dao);

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
      // final response = await rootBundle.loadString('assets/data/intraday_5min_AAPL.csv');
      // final result = await _companyIntradayInfoParser.parse(response);
      final response = await rootBundle.loadString('assets/data/listing_status.csv');
      final remoteList = await _companyListParser.parse(response);
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
    await Future.delayed(const Duration(seconds: 1));
    final response = {
      "Symbol": "AAPL",
      "AssetType": "Common Stock",
      "Name": "Apple Inc",
      "Description": "Apple Inc. is an American multinational technology company that specializes in consumer electronics, computer software, and online services. Apple is the world's largest technology company by revenue (totalling 274.5 billion in 2020) and, since January 2021, the world's most valuable company. As of 2021, Apple is the world's fourth-largest PC vendor by unit sales, and fourth-largest smartphone manufacturer. It is one of the Big Five American information technology companies, along with Amazon, Google, Microsoft, and Facebook.",
      "CIK": "320193",
      "Exchange": "NASDAQ",
      "Currency": "USD",
      "Country": "USA",
      "Sector": "TECHNOLOGY",
      "Industry": "ELECTRONIC COMPUTERS",
      "Address": "ONE INFINITE LOOP, CUPERTINO, CA, US",
      "FiscalYearEnd": "September",
      "LatestQuarter": "2023-06-30",
      "MarketCapitalization": "2736141107000",
      "EBITDA": "123957002000",
      "PERatio": "29.31",
      "PEGRatio": "2.75",
      "BookValue": "3.852",
      "DividendPerShare": "0.93",
      "DividendYield": "0.0055",
      "EPS": "5.97",
      "RevenuePerShareTTM": "24.22",
      "ProfitMargin": "0.247",
      "OperatingMarginTTM": "0.292",
      "ReturnOnAssetsTTM": "0.209",
      "ReturnOnEquityTTM": "1.601",
      "RevenueTTM": "383932989000",
      "GrossProfitTTM": "170782000000",
      "DilutedEPSTTM": "5.97",
      "QuarterlyEarningsGrowthYOY": "0.05",
      "QuarterlyRevenueGrowthYOY": "-0.014",
      "AnalystTargetPrice": "200.11",
      "TrailingPE": "29.31",
      "ForwardPE": "28.66",
      "PriceToSalesRatioTTM": "5.51",
      "PriceToBookRatio": "44.63",
      "EVToRevenue": "5.92",
      "EVToEBITDA": "23.52",
      "Beta": "1.275",
      "52WeekHigh": "197.96",
      "52WeekLow": "123.64",
      "50DayMovingAverage": "184.72",
      "200DayMovingAverage": "164.74",
      "SharesOutstanding": "15634200000",
      "DividendDate": "2023-08-17",
      "ExDividendDate": "2023-08-11"
    };
    final companyInfoDto = CompanyInfoDto.fromJson(
        json.decode(jsonEncode(response)));
    return companyInfoDto.toCompanyInfo();
  }

  @override
  Future<List<CompanyIntradayInfo>> fetchCompanyIntradayInfo(
      String symbol) async {
    try {
      final response = await rootBundle.loadString('assets/data/intraday_5min_AAPL.csv');
      final result = await _companyIntradayInfoParser.parse(response);
      return result;
    } catch (e) {
      throw Exception('Error StockRepositoryImpl fetchCompanyIntradayInfo: ${e
          .toString()}');
    }
  }
}