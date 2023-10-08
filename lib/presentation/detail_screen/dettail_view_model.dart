import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/use_case/fetch_company_info_use_case.dart';
import 'package:us_stock/domain/use_case/fetch_company_intraday_info_use_case.dart';
import 'package:us_stock/presentation/detail_screen/detail_state.dart';

class DetailViewModel with ChangeNotifier {
  final FetchCompanyInfoUseCase _companyInfoUseCase;
  final FetchCompanyIntradayInfoUseCase _companyIntradayInfoUseCase;
  final Company _selectedObject;

  // getter
  Company get selectedObject => _selectedObject;

  DetailState _state = const DetailState();

  // getter
  DetailState get state => _state;

  DetailViewModel(this._companyInfoUseCase, this._companyIntradayInfoUseCase, this._selectedObject, String symbol,
      ) {
    fetchCompanyInfo(symbol);
  }

  Future<void> fetchCompanyInfo(String symbol) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _companyInfoUseCase.execute(symbol);
    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
            companyInfo: data, isLoading: false);
      case Error(:final message):
        _state = state.copyWith(
            companyInfo: null, isLoading: false);
        log('Error DetailViewModel: $message');
    }
    notifyListeners();

    final intradayInfo = await _companyIntradayInfoUseCase.execute(symbol);
    switch (intradayInfo) {
      case Success(:final data):
        _state = _state.copyWith(
            companyIntradayInfo: data, isLoading: false);
        log('${data.toList().length}');
      case Error(:final message):
        _state = _state.copyWith(
            companyIntradayInfo: [], isLoading: false);
        log('Error DetailViewModel: $message');
    }
    notifyListeners();
  }
}