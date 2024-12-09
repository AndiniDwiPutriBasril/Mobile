import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';

class AddPengembalian extends StatelessWidget {
  static const routeName = '/add-pengembalian';

  final TextEditingController tanggalPengembalianController = TextEditingController();
  final TextEditingController terlambatController = TextEditingController();
  final TextEditingController dendaController = TextEditingController();
  final TextEditingController peminjamanIdController = TextEditingController();
  AddPengembalian({super.key});

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<Pengembalians>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD Pengembalian"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              players
                  .addPengembalian(
                tanggalPengembalianController.text,
                terlambatController.text,
                dendaController.text,
                peminjamanIdController.text,
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
                  labelText: "Tanggal Pengembalian",
                ),
                textInputAction: TextInputAction.next,
                controller: tanggalPengembalianController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Terlambat",
                ),
                textInputAction: TextInputAction.next,
                controller: terlambatController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Denda",
                ),
                textInputAction: TextInputAction.next,
                controller: dendaController,
              ),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: "Peminjaman ID",
                ),
                textInputAction: TextInputAction.next,
                controller: peminjamanIdController,
                onEditingComplete: () {
                  players
                      .addPengembalian(
                    tanggalPengembalianController.text,
                    terlambatController.text,
                    dendaController.text,
                    peminjamanIdController.text,
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
                        .addPengembalian(
                      tanggalPengembalianController.text,
                      terlambatController.text,
                      dendaController.text,
                      peminjamanIdController.text,
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
