import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';

class AddAnggota extends StatelessWidget {
  static const routeName = '/add-anggota';

  final TextEditingController nimController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  AddAnggota({super.key});

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Anggotas>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD Anggota"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              players
                  .addAnggota(
                nimController.text,
                namaController.text,
                alamatController.text,
                jenisKelaminController.text,
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
                  labelText: "NIM",
                ),
                textInputAction: TextInputAction.next,
                controller: nimController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Nama",
                ),
                textInputAction: TextInputAction.next,
                controller: namaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                ),
                textInputAction: TextInputAction.next,
                controller: alamatController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Jenis Kelamin",
                ),
                textInputAction: TextInputAction.next,
                controller: jenisKelaminController,
                onEditingComplete: () {
                  players
                      .addAnggota(
                    nimController.text,
                    namaController.text,
                    alamatController.text,
                    jenisKelaminController.text,
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
                        .addAnggota(
                      nimController.text,
                      namaController.text,
                      alamatController.text,
                      jenisKelaminController.text,
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
