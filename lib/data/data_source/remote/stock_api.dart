import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co';
  final apiKey = dotenv.get('apiKey');
  // Client 정의 (test code 작성 및 client 교체를 위해서)
  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  /// Listing Status API call
  Future<http.Response> fetchStocksList() async {
    return await _client.get(
        Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  /// Company Overview API call
  Future<http.Response> fetchCompanyInfo({required String symbol}) async {
    return await _client.get(Uri.parse(
        '$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));
  }

  /// Intraday API call
  Future<http.Response> fetchCompanyIntradayInfo({required String symbol}) async {
    return await _client.get(Uri.parse('$baseUrl/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=15min&extended_hours=false&datatype=csv&apikey=$apiKey'));
  }
}
