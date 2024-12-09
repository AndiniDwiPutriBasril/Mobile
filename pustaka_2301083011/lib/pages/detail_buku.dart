import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';

class DetailBuku extends StatelessWidget {
  static const routeName = '/detail-buku';

  const DetailBuku({super.key});

  @override
  Widget build(BuildContext context) {
    final bukus = Provider.of<Bukus>(context, listen: false);
    final bukuId = ModalRoute.of(context)!.settings.arguments as String;
    final selectBuku = bukus.selectById(bukuId);

    final TextEditingController kodeBukuController =
        TextEditingController(text: selectBuku.kode_buku);
    final TextEditingController judulController =
        TextEditingController(text: selectBuku.judul);
    final TextEditingController pengarangController =
        TextEditingController(text: selectBuku.pengarang);
    final TextEditingController penerbitController =
        TextEditingController(text: selectBuku.penerbit);
    final TextEditingController tahunTerbitController =
        TextEditingController(text: selectBuku.tahun_terbit);

    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAIL BUKU"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Kode Buku",
                ),
                textInputAction: TextInputAction.next,
                controller: kodeBukuController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Judul",
                ),
                textInputAction: TextInputAction.next,
                controller: judulController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Pengarang",
                ),
                textInputAction: TextInputAction.next,
                controller: pengarangController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Penerbit",
                ),
                textInputAction: TextInputAction.next,
                controller: penerbitController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Tahun Terbit",
                ),
                textInputAction: TextInputAction.done,
                controller: tahunTerbitController,
                onEditingComplete: () {
                  bukus.editBuku(
                    bukuId,
                    kodeBukuController.text,
                    judulController.text,
                    pengarangController.text,
                    penerbitController.text,
                    tahunTerbitController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    bukus.editBuku(
                      bukuId,
                      kodeBukuController.text,
                      judulController.text,
                      pengarangController.text,
                      penerbitController.text,
                      tahunTerbitController.text,
                      context,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "EDIT",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
