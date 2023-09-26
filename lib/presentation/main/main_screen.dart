import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:us_stock/presentation/main/main_state.dart';
import 'package:us_stock/presentation/main/main_view_model.dart';
import 'package:intl/intl.dart';

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

  Widget _buildSearchTextField(BuildContext context, viewModel) {
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
            // TODO: 쿼리 변경시 코드 구현
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
                _controller.clear();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(MainState state, viewModel) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          // TODO:
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: state.corporationList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Text(
                      state.corporationList[index].symbol,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    title: Text(
                      state.corporationList[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w600),
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
          ),
        ),
      ),
    );
  }
}
