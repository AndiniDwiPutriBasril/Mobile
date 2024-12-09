import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bukus.dart';

class AddBuku extends StatelessWidget {
  static const routeName = '/add-buku';

  final TextEditingController kodeBukuController = TextEditingController();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController pengarangController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunTerbitController = TextEditingController();
  AddBuku({super.key});

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Bukus>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD Buku"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              players
                  .addBuku(
                kodeBukuController.text,
                judulController.text,
                pengarangController.text,
                penerbitController.text,
                tahunTerbitController.text,
              )
                  .then(
                (response) {
                  print("Kembali ke home & kasih notif snack bar");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Berhasil ditambahkan"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
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
                textInputAction: TextInputAction.next,
                controller: tahunTerbitController,

                onEditingComplete: () {
                  players
                      .addBuku(
                    kodeBukuController.text,
                    judulController.text,
                    pengarangController.text,
                    penerbitController.text,
                    tahunTerbitController.text,
                  )
                      .then(
                    (response) {
                      print("Kembali ke home & kasih notif snack bar");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Berhasil ditambahkan"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    players
                        .addBuku(
                      kodeBukuController.text,
                      judulController.text,
                      pengarangController.text,
                      penerbitController.text,
                      tahunTerbitController.text,
                    )
                        .then(
                      (response) {
                        print("Kembali ke home & kasih notif snack bar");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Berhasil ditambahkan"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
