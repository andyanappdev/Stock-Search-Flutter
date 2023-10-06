import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/use_case/fetch_company_list_use_case.dart';
import 'package:us_stock/domain/use_case/fetch_favorite_company_list_use_case.dart';
import 'package:us_stock/domain/use_case/update_favorite_use_case.dart';
import 'package:us_stock/presentation/main/main_event.dart';
import 'package:us_stock/presentation/main/main_state.dart';

class MainViewModel with ChangeNotifier {
  final FetchCompanyListUseCase _companyListUseCase;
  final FetchFavoriteCompanyListUseCase _favoriteCompanyListUseCase;
  final UpdateFavoriteUseCase _updateFavoriteUseCase;

  MainState _state = const MainState();

  // getter
  MainState get state => _state;

  // // debounce용 타이머
  Timer? _debounce;

  MainViewModel(this._companyListUseCase, this._favoriteCompanyListUseCase, this._updateFavoriteUseCase) {
    _fetchFavoriteCompanyList();
  }

  Future<void> onEvent(MainEvent event) async {
    switch (event) {
      case Refresh():
        // remote에서 데이터 다시 가져오기
        _fetchCompanyList(fetchFromRemote: true);
      case SerachQueryChange(:final query):
        // query가 입력되고 500ms 이후에 실행되도록
        // (사용자 빠르게 타입하는 것을 모두 반영하지 않고 약간의 딜레이를 주기 위해)
        _debounce?.cancel();
        _debounce = Timer(const Duration(microseconds: 300), () {
          _fetchCompanyList(query: query);
        });
      case FavoriteChange():
        await _updateFavorite(event.selectedObject);
        await _fetchCompanyList(fetchFromRemote: false, query: event.query);
    }
  }

  Future<void> _fetchCompanyList(
      {bool fetchFromRemote = false, String query = ''}) async {
    // 1. isLoading state 변경
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    // 2. fetchCorporationList
    final result = await _companyListUseCase.execute(fetchFromRemote, query);
    switch (result) {
      case Success(:final data):
        _state = state.copyWith(companyList: data);
      case Error(:final message):
        log('Error MainViewModel: $message');
    }

    // 3. isLoading state 변경
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _fetchFavoriteCompanyList() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _favoriteCompanyListUseCase.execute();
    switch (result) {
      case Success(:final data):
        _state = state.copyWith(favoriteList: data);
      case Error(:final message):
        log('Error MainViewModel: $message');
    }

    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> _updateFavorite(Company selectedObject) async {
    await _updateFavoriteUseCase.execute(selectedObject);
    notifyListeners();
    await _fetchFavoriteCompanyList();
    notifyListeners();
  }
}
