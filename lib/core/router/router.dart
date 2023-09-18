import 'package:go_router/go_router.dart';
import 'package:us_stock/presentation/detail_screen/detail_screen.dart';
import 'package:us_stock/presentation/main/main_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: '/second',
      builder: (context, state) => DetailScreen(),
    ),
  ],
);
