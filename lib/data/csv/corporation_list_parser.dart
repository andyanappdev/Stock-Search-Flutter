import 'package:csv/csv.dart';
import 'package:us_stock/data/csv/csv_parser_interface.dart';
import 'package:us_stock/domain/model/corporation_list.dart';

class CorporationListParser implements CsvParser {
  @override
  Future<List<CorporationList>> parse(String csvString) async {
    // CSV to list
    List<List<dynamic>> csvValues =
        const CsvToListConverter().convert(csvString);
    // 첫줄 label 삭제
    csvValues.removeAt(0);
    return csvValues
        .map((e) {
          final symbol = e[0] ?? '';
          final name = e[1] ?? '';
          final exchange = e[2] ?? '';
          final assetType = e[3] ?? '';
          final ipoDate = e[4] ?? '';
          final status = e[6] ?? '';
          return CorporationList(
            symbol: symbol,
            name: name,
            exchange: exchange,
            assetType: assetType,
            ipoDate: DateTime.parse(ipoDate),
            status: status,
          );
        })
        .where((e) =>
            e.symbol.isNotEmpty &&
            e.name.isNotEmpty &&
            e.exchange.isNotEmpty &&
            e.assetType.isNotEmpty &&
            e.status.isNotEmpty)
        .toList();
  }
}
