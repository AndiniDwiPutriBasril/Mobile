import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pengembalians.dart';

class DetailPengembalian extends StatelessWidget {
  static const routeName = '/detail-pengembalian';

  const DetailPengembalian({super.key});

  @override
  Widget build(BuildContext context) {
    final pengembalians = Provider.of<Pengembalians>(context, listen: false);
    final pengembalianId = ModalRoute.of(context)!.settings.arguments as String;
    final selectPengembalian = pengembalians.selectById(pengembalianId);

    final TextEditingController tanggalPengembalianController =
        TextEditingController(text: selectPengembalian.tanggal_pengembalian);
    final TextEditingController terlambatController =
        TextEditingController(text: selectPengembalian.terlambat);
    final TextEditingController dendaController =
        TextEditingController(text: selectPengembalian.denda);
    final TextEditingController peminjamanIdController =
        TextEditingController(text: selectPengembalian.peminjaman_id.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAIL PENGEMBALIAN"),
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
                textInputAction: TextInputAction.done,
                controller: peminjamanIdController,
                onEditingComplete: () {
                  pengembalians.editPengembalian(
                    pengembalianId,
                    tanggalPengembalianController.text,
                    terlambatController.text,
                    dendaController.text,
                    peminjamanIdController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    pengembalians.editPengembalian(
                      pengembalianId,
                      tanggalPengembalianController.text,
                      terlambatController.text,
                      dendaController.text,
                      peminjamanIdController.text,
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
