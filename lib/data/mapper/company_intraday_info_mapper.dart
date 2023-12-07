import 'package:intl/intl.dart';
import 'package:us_stock/data/data_source/remote/company_intraday_info_dto.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';

extension ToCompanyIntradayInfo on CompanyIntradayInfoDto {
  CompanyIntradayInfo toCompanyIntradayInfo() {
    return CompanyIntradayInfo(
      timeStamp: DateFormat('yyyy-MM-dd HH:mm:ss').parse(timestamp ?? '2023-01-01 00:00:00'),
      open: open?.toDouble() ?? 0.0,
      high: high?.toDouble() ?? 0.0,
      low: low?.toDouble() ?? 0.0,
      close: close?.toDouble() ?? 0.0,
      volume: volume?.toInt() ?? 0,
    );
  }
}
