import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

part 'main_state.freezed.dart';

part 'main_state.g.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default([]) List<CorporationList> corporationList,
    @Default(false) bool favorite,
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default('') String searchQuery,
  }) = _MainState;

  factory MainState.fromJson(Map<String, Object?> json) =>
      _$MainStateFromJson(json);
}
