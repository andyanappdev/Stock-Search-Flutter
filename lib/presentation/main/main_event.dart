import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:us_stock/domain/model/company.dart';

part 'main_event.freezed.dart';

@freezed
sealed class MainEvent with _$MainEvent {
  const factory MainEvent.refresh() = Refresh;
  const factory MainEvent.searchQueryChange(String query) = SerachQueryChange;
  const factory MainEvent.favoriteChange(Company selectedObject, String query) = FavoriteChange;
}
