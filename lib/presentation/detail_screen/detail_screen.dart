import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:us_stock/presentation/detail_screen/components/company_chart.dart';
import 'package:us_stock/presentation/detail_screen/detail_state.dart';
import 'package:us_stock/presentation/detail_screen/dettail_view_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: _buildAppBar(context, viewModel),
      body: SafeArea(
        child: Stack(
          children: [
            if (state.isLoading)
              const Center(
                  child: CupertinoActivityIndicator(
                radius: 20.0,
                color: CupertinoColors.link,
              )),
            if (state.isLoading == false &&
                state.companyInfo != null &&
                state.companyIntradayInfo.isNotEmpty)
              _buildBody(context, viewModel, state),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, DetailViewModel viewModel) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    viewModel.selectedObject.symbol,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  SizedBox(
                    width: 190,
                    child: Text(
                      viewModel.selectedObject.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.outline,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.share),
                    iconSize: 22.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined, color: Colors.blue),
                    iconSize: 22.0,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildBody(
      BuildContext context, DetailViewModel viewModel, DetailState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.companyIntradayInfo.last.close.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                    '${state.companyInfo!.exchange} - ${state.companyInfo!.currency}'),
              ],
            ),
            const Divider(),
            if (state.companyIntradayInfo.isNotEmpty)
              _buildCompanyChart(context, viewModel),
            const SizedBox(height: 10),
            _buildCompanyMetrics(context, state, viewModel),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            _buildBasicInfo(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyChart(BuildContext context, DetailViewModel viewModel) {
    return CompanyChart(viewModel: viewModel);
  }

  Widget _buildCompanyMetrics(
      BuildContext context, DetailState state, DetailViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '개장가',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                '최고가',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                '최저가',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
          const SizedBox(width: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                state.companyIntradayInfo.first.open.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                viewModel.calculateValue('max').toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                viewModel.calculateValue('min').toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
          const SizedBox(width: 50.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '시가총액',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                'PER',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                'EPS',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
          const SizedBox(width: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                viewModel
                    .formatMarketCap(state.companyInfo!.marketCapitalization),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                state.companyInfo!.per,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                state.companyInfo!.eps,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
          const SizedBox(width: 50.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '배당 수익률',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                '이익 마진',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                'PBR',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
          const SizedBox(width: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                state.companyInfo!.dividendYield,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                state.companyInfo!.profitMargin,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                state.companyInfo!.priceToBookRatio,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
          const SizedBox(width: 50.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '52주 최고',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                '52주 최저',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
              Text(
                '베타',
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.outline),
              ),
            ],
          ),
          const SizedBox(width: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                state.companyInfo!.weekHigh,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                state.companyInfo!.weekLow,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              Text(
                state.companyInfo!.beta,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context, DetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text.rich(
            TextSpan(
              text: 'Country : ', // default text style
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.outline),
              children: [
                TextSpan(
                  text: state.companyInfo!.country,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text.rich(
            overflow: TextOverflow.ellipsis,
            TextSpan(
              text: 'Address : ', // default text style
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.outline),
              children: [
                TextSpan(
                  text: state.companyInfo!.address,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text.rich(
            overflow: TextOverflow.ellipsis,
            TextSpan(
              text: 'Sector : ', // default text style
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.outline),
              children: [
                TextSpan(
                  text: state.companyInfo!.sector,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text.rich(
            overflow: TextOverflow.ellipsis,
            TextSpan(
              text: 'Industry : ', // default text style
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.outline),
              children: [
                TextSpan(
                  text: state.companyInfo!.industry,
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            'Description',
            style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.outline),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Text(
            state.companyInfo!.description,
            style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onBackground),
            // overflow: TextOverflow.ellipsis,
            // maxLines: null,
          ),
        ),
      ],
    );
  }
}