import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/home_page.dart';
import 'pages/add_anggota_page.dart';
import 'pages/add_buku_page.dart';
import 'pages/add_peminjaman_page.dart';
import 'pages/add_pengembalian_page.dart';
import 'pages/detail_anggota.dart';
import 'pages/detail_buku.dart';
import 'pages/detail_peminjaman.dart';
import 'pages/detail_pengembalian.dart';
import 'pages/welcome_screen.dart';
import 'pages/login_page.dart';
import 'providers/anggotas.dart';
import 'providers/bukus.dart';
import 'providers/peminjamans.dart';
import 'providers/pengembalians.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Anggotas()),
        ChangeNotifierProvider(create: (context) => Bukus()),
        ChangeNotifierProvider(create: (context) => Peminjamans()),
        ChangeNotifierProvider(create: (context) => Pengembalians()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          AddAnggota.routeName: (context) => AddAnggota(),
          AddBuku.routeName: (context) => AddBuku(),
          AddPeminjaman.routeName: (context) => AddPeminjaman(),
          AddPengembalian.routeName: (context) => AddPengembalian(),
          DetailAnggota.routeName: (context) => DetailAnggota(),
          DetailBuku.routeName: (context) => DetailBuku(),
          DetailPeminjaman.routeName: (context) => DetailPeminjaman(),
          DetailPengembalian.routeName: (context) => DetailPengembalian(),
        },
      ),
    );
  }
}
