import 'package:flutter/material.dart';
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
    final List<CompanyIntradayInfo> chartData = viewModel.state.companyIntradayInfo;
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        // // title: ChartTitle(text: 'Intraday Chart'),
        // primaryXAxis: DateTimeAxis(),
        // primaryYAxis: NumericAxis(),
        // series: <ChartSeries>[
        //   // Renders fast line chart
        //   FastLineSeries<CompanyIntradayInfo, DateTime>(
        //     dataSource: chartData,
        //     xValueMapper: (CompanyIntradayInfo data, _) => data.timeStamp,
        //     yValueMapper: (CompanyIntradayInfo data, _) => data.close,
        //   )
        // ],
      ),
    );
  }
}