import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/all_product.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key); // Perbaikan argumen di konstruktor

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(), // Perbaikan penggunaan lambda expression
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop', // Perbaikan 'litle' menjadi 'title'
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo, // Menggunakan primarySwatch yang valid
            accentColor: Colors.amber, // Tambahkan accentColor sesuai dengan ColorScheme lama
          ),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
