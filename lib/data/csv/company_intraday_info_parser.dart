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

    // csvValues를 시간 순서대로 정렬
    csvValues.sort((a,b) {
      final timestampA = DateTime.tryParse(a[0] ?? '');
      final timestampB = DateTime.tryParse(b[0] ?? '');

      if (timestampA == null || timestampB == null) {
        return 0;
      }
      return timestampA.compareTo(timestampB);
    });

    // 변경된 날짜의 인덱스를 찾기
    int changeDateIndex = -1;
    final currentDate = DateTime.tryParse(csvValues[0][0] ?? '');
    for (int i = 1; i < csvValues.length; i++) {
      final nextDate = DateTime.tryParse(csvValues[i][0] ?? '');
      if (nextDate != null && nextDate.day != currentDate!.day) {
        changeDateIndex = i;
        break;
      }
    }

    if (changeDateIndex != -1) {
      // 변경된 날짜 이후의 데이터만 파싱
      csvValues = csvValues.sublist(changeDateIndex);
    }

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