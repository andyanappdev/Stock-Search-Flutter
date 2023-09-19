import 'package:us_stock/data/csv/corporation_list_parser.dart';
import 'package:us_stock/data/data_source/local/corporation_list_entity.dart';
import 'package:us_stock/data/data_source/local/stock_dao.dart';
import 'package:us_stock/data/data_source/remote/stock_api.dart';
import 'package:us_stock/data/mapper/corporation_list_mapper.dart';
import 'package:us_stock/domain/model/corporation_info.dart';
import 'package:us_stock/domain/model/corporation_list.dart';
import 'package:us_stock/domain/repository/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final StockApi _api;
  final StockDao _dao;
  final CorporationListParser _parser = CorporationListParser();

  StockRepositoryImpl(this._api, this._dao);

  @override
  Future<List<CorporationList>> fetchCorporationList(
      bool fetchFromRemote, String query) async {
    // 1. cache에서 데이터 찾기
    final List<CorporationListEntity> localList =
        await _dao.searchCorporation(query);
    // 2. cache에 데이터가 없다면 remote에서 가져 온다
    final isDbEmpty = localList.isEmpty && query.isEmpty;
    // 조건
    final shouldLoadFromCache = !isDbEmpty && !fetchFromRemote;
    // cache에서 가져오기
    if (shouldLoadFromCache) {
      return localList.map((e) => e.toCorporationList()).toList();
    }
    // remote에서 가져오기
    try {
      final response = await _api.fetchStocksList();
      final remoteList = await _parser.parse(response.body);
      // 기존에 있던 cache 비워주기 (clear 작업이 없으면 계속해서 뒤에 add 되기 때문)
      await _dao.clearCorporationList();
      // 새로 remote 에서 받아온 data cache에 추가
      await _dao.insertCorporationList(
          remoteList.map((e) => e.toCorporationListEntity()).toList());
      return remoteList;
    } catch (e) {
      throw Exception(
          'Error StockRepositoryImpl fetchCorporationList: ${e.toString()}');
    }
  }

  @override
  Future<CorporationInfo> fetchCorporationInfo(String symbol) async {
    // TODO: implement fetchCorporationInfo
    throw UnimplementedError();
  }
}
