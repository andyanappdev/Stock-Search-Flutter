import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:us_stock/data/data_source/local/company_entity.dart';
import 'package:us_stock/data/data_source/local/favorite_entity.dart';
import 'core/router/router.dart';
import 'core/color_schemes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // Initializes Hive with a valid directory in your app files.
  await Hive.initFlutter();
  // Register Adapter
  Hive.registerAdapter(CompanyEntityAdapter());
  Hive.registerAdapter(FavoriteEntityAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'US Stock',
      theme: ThemeData(
        fontFamily: 'HelevticalNenu',
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      // 반응형 대응
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
    );
  }
}
