import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:us_stock/core/result.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/domain/use_case/fetch_company_info_use_case.dart';
import 'package:us_stock/presentation/detail_screen/detail_state.dart';

class DetailViewModel with ChangeNotifier {
  final FetchCompanyInfoUseCase _companyInfoUseCase;
  final Company _selectedObject;
  // getter
  Company get selectedObject => _selectedObject;

  DetailState _state = const DetailState();
  // getter
  DetailState get state => _state;

  DetailViewModel(this._companyInfoUseCase, this._selectedObject, String symbol) {
   fetchCompanyInfo(symbol);
  }

  Future<void> fetchCompanyInfo(String symbol) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _companyInfoUseCase.execute(symbol);
    switch (result) {
      case Success(:final data):
        _state = state.copyWith(companyInfo: data, isLoading: false, errorMessage: null);
      case Error(:final message):
        _state = state.copyWith(companyInfo: null, isLoading: false, errorMessage: message);
        log('Error DetailViewModel: $message');
    }
    notifyListeners();
  }
}