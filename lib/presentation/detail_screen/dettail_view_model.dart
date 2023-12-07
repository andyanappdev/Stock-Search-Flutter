import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    _fetchCompanyInfo(symbol);
  }

  Future<void> _fetchCompanyInfo(String symbol) async {
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

  double calculateValue(String which) {
    List<double> values = _state.companyIntradayInfo.map((e) => e.high).toList();
    double result;

    if (which == 'max') {
      result = values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 0.0;
    } else if (which == 'min') {
      result = values.isNotEmpty ? values.reduce((a, b) => a < b ? a : b) : 0.0;
    } else {
      // 예외 처리: 'max' 또는 'min' 외의 값이 파라미터로 전달된 경우
      throw ArgumentError('Invalid parameter: $which');
    }
    return result;
  }

  String formatMarketCap(String marketCap) {
    final toNum = num.tryParse(marketCap);
    final formatter = NumberFormat.compact(locale: 'ko_KR');
    return formatter.format(toNum);
  }
}