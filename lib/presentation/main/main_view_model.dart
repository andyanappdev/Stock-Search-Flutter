import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/use_case/fetch_corporation_list_use_case.dart';
import 'package:us_stock/presentation/main/main_state.dart';

class MainViewModel with ChangeNotifier {
  final FetchCorporationListUseCase _corporationListUseCase;

  MainState _state = const MainState();
  // getter
  MainState get state => _state;

  MainViewModel(this._corporationListUseCase) {
    _fetchCorporationList();
  }

  Future<void> _fetchCorporationList(
      {bool fetchFromRemote = false, String query = ''}) async {
    // 1. isLoading state 변경
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    // 2. fetchCorporationList
    final result =
        await _corporationListUseCase.execute(fetchFromRemote, query);
    switch (result) {
      case Success(:final data):
        _state = state.copyWith(corporationList: data);
      case Error(:final message):
        log('Error MainViewModel: $message');
    }

    // 3. isLoading state 변경
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
