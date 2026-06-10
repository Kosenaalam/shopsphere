import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopsphere/features/products/presentation/screens/product_list_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

      await Hive.initFlutter();
      await Hive.openBox('wishlist');

      runApp(
          const ProviderScope(
          child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false,
          theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          ),
      home: const ProductListScreen(),
    );
  }
}