import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';
import '../providers/bukus.dart';
import '../providers/peminjamans.dart';
import '../providers/pengembalians.dart';
import 'add_anggota_page.dart';
import 'add_buku_page.dart';
import 'add_peminjaman_page.dart';
import 'add_pengembalian_page.dart';
import 'detail_anggota.dart';
import 'detail_buku.dart';
import 'detail_peminjaman.dart';
import 'detail_pengembalian.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Anggotas>(context).initializeData();
      Provider.of<Bukus>(context).initializeData();
      Provider.of<Peminjamans>(context).initializeData();
      Provider.of<Pengembalians>(context).initializeData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final anggotasProvider = Provider.of<Anggotas>(context);
    final bukusProvider = Provider.of<Bukus>(context);
    final peminjamansProvider = Provider.of<Peminjamans>(context);
    final pengembaliansProvider = Provider.of<Pengembalians>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Library Management"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            "Anggota",
            anggotasProvider.allAnggota,
            AddAnggota.routeName,
            DetailAnggota.routeName,
          ),
          _buildSection(
            context,
            "Buku",
            bukusProvider.allBuku,
            AddBuku.routeName,
            DetailBuku.routeName,
          ),
          _buildSection(
            context,
            "Peminjaman",
            peminjamansProvider.allPeminjaman,
            AddPeminjaman.routeName,
            DetailPeminjaman.routeName,
          ),
          _buildSection(
            context,
            "Pengembalian",
            pengembaliansProvider.allPengembalian,
            AddPengembalian.routeName,
            DetailPengembalian.routeName,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List items,
    String addRoute,
    String detailRoute,
  ) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        children: [
          if (items.isEmpty)
            const ListTile(
              title: Text("No Data"),
            )
          else
            ...items.map((item) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      item.toString(),
                      style: const TextStyle(color: Colors.black87),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        detailRoute,
                        arguments: item.id,
                      );
                    },
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
          ListTile(
            title: const Text("Add New"),
            trailing: const Icon(Icons.add, color: Colors.green),
            onTap: () {
              Navigator.pushNamed(context, addRoute);
            },
          ),
        ],
      ),
    );
  }
}
