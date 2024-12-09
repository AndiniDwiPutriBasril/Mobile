import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart';

class AddPeminjaman extends StatelessWidget {
  static const routeName = '/add-peminjaman';

  final TextEditingController tanggalPinjamController = TextEditingController();
  final TextEditingController tanggalKembaliController = TextEditingController();
  final TextEditingController anggotaIdController = TextEditingController();
  final TextEditingController bukuIdController = TextEditingController();

  AddPeminjaman({super.key});

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Peminjamans>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD Peminjaman"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              players
                  .addPeminjaman(
                tanggalPinjamController.text,
                tanggalKembaliController.text,
                anggotaIdController.text,
                bukuIdController.text,
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
                  labelText: "Tanggal Pinjam",
                ),
                textInputAction: TextInputAction.next,
                controller: tanggalPinjamController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Tanggal Kembali",
                ),
                textInputAction: TextInputAction.next,
                controller: tanggalKembaliController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Anggota ID",
                ),
                textInputAction: TextInputAction.next,
                controller: anggotaIdController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Buku ID",
                ),
                textInputAction: TextInputAction.next,
                controller: bukuIdController,
                onEditingComplete: () {
                  players
                      .addPeminjaman(
                    tanggalPinjamController.text,
                    tanggalKembaliController.text,
                    anggotaIdController.text,
                    bukuIdController.text,
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
                        .addPeminjaman(
                      tanggalPinjamController.text,
                      tanggalKembaliController.text,
                      anggotaIdController.text,
                      bukuIdController.text,
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
