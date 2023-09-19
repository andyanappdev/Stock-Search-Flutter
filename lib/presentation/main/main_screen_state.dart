import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

part 'main_screen_state.freezed.dart';

part 'main_screen_state.g.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    @Default([]) List<CorporationList> corporationList,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default('') String searchQuery,
  }) = _MainScreenState;

  factory MainScreenState.fromJson(Map<String, Object?> json) =>
      _$MainScreenStateFromJson(json);
}
