import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_stock/domain/model/company.dart';
import 'package:us_stock/presentation/main/main_event.dart';
import 'package:us_stock/presentation/main/main_view_model.dart';

class FavoriteListViewBuilder extends StatelessWidget {
  final TextEditingController controller;
  final MainViewModel viewModel;

  const FavoriteListViewBuilder({
    super.key,
    required this.controller,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;
    return ListView.builder(
      itemCount: state.favoriteList.length,
      itemBuilder: (context, index) {
        Company selectedObject = state.favoriteList[index];
        return Column(
          children: [
            Dismissible(
              key: Key(selectedObject.symbol),
              // The direction in which the widget can be dismissed.
              direction: DismissDirection.endToStart,
              // Show a red background as the item is swiped away.
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                color: Colors.redAccent,
                child: const Icon(Icons.delete_forever),
              ),
              // The offset threshold the item has to be dragged in order to be considered dismissed.
              dismissThresholds: const {DismissDirection.endToStart: 0.5} ,
              onDismissed: (direction) async {
                  await viewModel.onEvent(FavoriteChange(selectedObject,controller.text));
              },
              confirmDismiss: (direction) async {
                return await _confirmDismiss(context, selectedObject.name);
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    state.favoriteList[index].symbol,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  subtitle: Text(
                    state.favoriteList[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Text('Test'
                    // state.favoriteList[index].
                  ),
                  onTap: () {
                    // TODO:
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _confirmDismiss(BuildContext context, String name) async {
    return await showCupertinoModalPopup<bool>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Are you sure?'),
        content: Text('Delete $name'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
