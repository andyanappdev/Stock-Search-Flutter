import 'package:csv/csv.dart';
import 'package:us_stock/data/csv/csv_parser_interface.dart';
import 'package:us_stock/data/data_source/remote/company_intraday_info_dto.dart';
import 'package:us_stock/data/mapper/company_intraday_info_mapper.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';

class CompanyIntradayInfoParser implements CsvParser<CompanyIntradayInfo> {
  @override
  Future<List<CompanyIntradayInfo>> parse(String csvString) async {
    // CSV to list
    List<List<dynamic>> csvValues = const CsvToListConverter().convert(csvString);
    // 첫줄 label 삭제
    csvValues.removeAt(0);
    return csvValues.map((e) {
      final timestamp = e[0] ?? '';
      final open = e[1] ?? 0.0;
      final high = e[2] ?? 0.0;
      final low = e[3] ?? 0.0;
      final close = e[4] ?? 0.0;
      final volume = e[5] ?? 0;
      final dto = CompanyIntradayInfoDto(
        timestamp: timestamp,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume);
      return dto.toCompanyIntradayInfo();
    }).toList();
  }
}