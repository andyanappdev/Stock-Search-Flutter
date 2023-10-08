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
            if (state.isLoading == false && state.companyInfo != null && state.companyIntradayInfo.isNotEmpty)
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

  Widget _buildBody(BuildContext context, DetailViewModel viewModel, DetailState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${state.companyInfo!.exchange} - ${state.companyInfo!.currency}'),
            ],
          ),
          const Divider(),
          if (state.companyIntradayInfo.isNotEmpty) _buildCompanyChart(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildCompanyChart(BuildContext context, DetailViewModel viewModel) {
    return CompanyChart(viewModel: viewModel);
  }

}