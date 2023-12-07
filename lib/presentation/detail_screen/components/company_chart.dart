import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:us_stock/domain/model/company_intraday_info.dart';
import 'package:us_stock/presentation/detail_screen/dettail_view_model.dart';

class CompanyChart extends StatelessWidget {
  final DetailViewModel viewModel;

  const CompanyChart({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();
    // List<ChartData> chartData = getChartData();
    final List<CompanyIntradayInfo> chartData =
        viewModel.state.companyIntradayInfo;
    return SizedBox(
      width: double.infinity,
      // height: 600,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: SfCartesianChart(
              // title: ChartTitle(text: 'Intraday Chart'),
              primaryXAxis: DateTimeAxis(interval: 1),
              primaryYAxis: NumericAxis(
                numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
                opposedPosition: true,
                labelPosition: ChartDataLabelPosition.outside,
              ),
              plotAreaBorderWidth: 0,  // 그래프 외곽선
              series: <ChartSeries>[
                // Renders fast line chart
                FastLineSeries<CompanyIntradayInfo, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (CompanyIntradayInfo data, _) => data.timeStamp,
                  yValueMapper: (CompanyIntradayInfo data, _) => data.close,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   height: 50,
          //   child: SfCartesianChart(
          //     primaryYAxis: DateTimeCategoryAxis(interval: 1),
          //     primaryXAxis: NumericAxis(),
          //     series: <ChartSeries>[
          //       ColumnSeries<CompanyIntradayInfo, DateTime>(
          //         dataSource: chartData,
          //         xValueMapper: (CompanyIntradayInfo data, _) => data.timeStamp,
          //         yValueMapper: (CompanyIntradayInfo data, _) => data.volume,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}