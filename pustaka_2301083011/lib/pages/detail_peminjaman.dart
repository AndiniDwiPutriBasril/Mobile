import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/peminjamans.dart';

class DetailPeminjaman extends StatelessWidget {
  static const routeName = '/detail-peminjaman';

  const DetailPeminjaman({super.key});

  @override
  Widget build(BuildContext context) {
    final peminjamans = Provider.of<Peminjamans>(context, listen: false);
    final peminjamanId = ModalRoute.of(context)!.settings.arguments as String;
    final selectPeminjaman = peminjamans.selectById(peminjamanId);

    final TextEditingController tanggalPinjamController =
        TextEditingController(text: selectPeminjaman.tanggal_pinjam);
    final TextEditingController tanggalKembaliController =
        TextEditingController(text: selectPeminjaman.tanggal_kembali);
    final TextEditingController anggotaIdController =
        TextEditingController(text: selectPeminjaman.anggota_id.toString());
    final TextEditingController bukuIdController =
        TextEditingController(text: selectPeminjaman.buku_id.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAIL PEMINJAMAN"),
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
                textInputAction: TextInputAction.done,
                controller: bukuIdController,
                onEditingComplete: () {
                  peminjamans.editPeminjaman(
                    peminjamanId,
                    tanggalPinjamController.text,
                    tanggalKembaliController.text,
                    anggotaIdController.text,
                    bukuIdController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    peminjamans.editPeminjaman(
                      peminjamanId,
                      tanggalPinjamController.text,
                      tanggalKembaliController.text,
                      anggotaIdController.text,
                      bukuIdController.text,
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
