import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/presentation/main/main_event.dart';
import 'package:us_stock/presentation/main/main_view_model.dart';

class CompanyListViewBuilder extends StatelessWidget {
  final TextEditingController controller;
  final MainViewModel viewModel;

  const CompanyListViewBuilder({
    super.key,
    required this.controller,
    required this.viewModel,
  });


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;
    return ListView.builder(
      itemCount: state.companyList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              leading: Text(
                state.companyList[index].symbol,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              title: Text(
                state.companyList[index].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.w600),
              ),
              trailing: GestureDetector(
                child: Icon(
                  state.companyList[index].favorite
                      ? Icons.check_circle
                      : Icons.add_circle_outline_outlined,
                  color: Colors.blueAccent,
                ),
                onTap: () {
                  Company selectedObject = state.companyList[index];
                  viewModel.onEvent(FavoriteChange(selectedObject,controller.text));
                },
              ),
              onTap: () {
                // TODO:
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
            ),
          ],
        );
      },
    );
  }
}