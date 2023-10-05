import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:us_stock/presentation/main/components/company_list_view_builder.dart';
import 'package:us_stock/presentation/main/components/favorite_list_view_builder.dart';
import 'package:us_stock/presentation/main/main_event.dart';
import 'package:us_stock/presentation/main/main_state.dart';
import 'package:us_stock/presentation/main/main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _textFocus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _textFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;
    return GestureDetector(
      onTap: () {
        _textFocus.unfocus();
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            _buildSearchTextField(context, viewModel),
            _buildMakeNewFavoriteList(state, viewModel),
            _buildListView(state, viewModel),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'US Stock',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                (DateFormat('M월 d일').format(DateTime.now())),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
      elevation: 0.0,
    );
  }

  Widget _buildSearchTextField(BuildContext context, MainViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: _controller,
          focusNode: _textFocus,
          cursorColor: Theme.of(context).colorScheme.onBackground,
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          onChanged: (query) {
            viewModel.onEvent(MainEvent.searchQueryChange(query));
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                width: 2.0,
              ),
            ),
            labelText: 'Search',
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear_rounded),
              onPressed: () {
                // setState 말고 더 있어 보이는 방법은?
                // MainEvent에 fetchFavoriteList을 정의해서 처리 할수 있으나 작성해야할 코드가 많아져서 효율성 검토 필요
                setState(() {
                  _controller.clear();
                });

                // viewModel.
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMakeNewFavoriteList(MainState state, MainViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: GestureDetector(
        child: const Row(
          children: [
            Text(
              'My Favorite List ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.blueAccent,
              ),
            ),
            Icon(
              Icons.list,
              color: Colors.blueAccent,
            ),
          ],
        ),
        onTap: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Coming in the Future'),
              content: const Text('Create and manage new lists'),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  /// This parameter indicates this action is the default,
                  /// and turns the action's text to bold text.
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildListView(MainState state, MainViewModel viewModel) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          viewModel.onEvent(const MainEvent.refresh());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _controller.text.isEmpty
              ? FavoriteListViewBuilder(
                  controller: _controller, viewModel: viewModel)
              : CompanyListViewBuilder(
                  controller: _controller, viewModel: viewModel),
        ),
      ),
    );
  }
}
