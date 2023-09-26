import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:us_stock/data/csv/corporation_list_parser.dart';
import 'package:us_stock/data/data_source/remote/stock_api.dart';

void main() {
  test('API and Parser test', () async {
    await dotenv.load(fileName: '.env');
    // StockApi test
    final response = await StockApi().fetchStocksList();

    // parser test
    final parser = CompanyListParser();
    final remoteList = await parser.parse(response.body);

    expect(remoteList[0].symbol, 'A');
    expect(remoteList[1].name, 'Alcoa Corp');
    expect(remoteList[2].exchange, 'NYSE ARCA');
    expect(remoteList[3].assetType, "ETF");
    expect(remoteList[4].ipoDate, DateTime.parse('2021-03-25'));
    expect(remoteList[6].status, 'Active');
  });
}
