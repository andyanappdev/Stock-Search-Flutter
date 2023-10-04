import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:us_stock/data/data_source/local/stock_dao.dart';
import 'package:us_stock/data/data_source/remote/stock_api.dart';
import 'package:us_stock/data/repository/stock_repository_impl.dart';
import 'package:us_stock/domain/use_case/fetch_corporation_list_use_case.dart';
import 'package:us_stock/domain/use_case/fetch_favorite_company_list_use_case.dart';
import 'package:us_stock/presentation/detail_screen/detail_screen.dart';
import 'package:us_stock/presentation/main/main_screen.dart';
import 'package:us_stock/presentation/main/main_view_model.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MainViewModel(FetchCompanyListUseCase(
              StockRepositoryImpl(StockApi(), StockDao())), FetchFavoriteCompanyListUseCase(StockRepositoryImpl(StockApi(), StockDao()))),
          child: const MainScreen(),
        );
      },
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) => DetailScreen(),
    ),
  ],
);
