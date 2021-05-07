import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:food_x/ui/main_screen.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'data/memory_repository.dart';
import 'mock_service/mock_service.dart';

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MultiProvider(
        // 1
        providers: [
          // 2
          ChangeNotifierProvider<MemoryRepository>(
            lazy: false,
            create: (_) => MemoryRepository(),
          ),
          // 3
          FutureProvider(
            // 4
            create: (_) async {
              final service = MockService();
              // 5
              service.create();
              return service;
            },
            lazy: false,
          ),
        ],
        // 6
        child: MaterialApp(
          title: 'Recipes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const MainScreen(),
        ));
  }
}
