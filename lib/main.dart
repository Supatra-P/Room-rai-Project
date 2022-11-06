import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roomrai1/db/db_Helper.dart';
import 'package:roomrai1/provider/favorite_provider.dart';
import 'package:roomrai1/provider/transaction_provider.dart';
import 'package:roomrai1/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:roomrai1/screens/start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const startPage(),
      ),
    );
  }
}
