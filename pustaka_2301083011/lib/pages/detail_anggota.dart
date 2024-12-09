import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/anggotas.dart';

class DetailAnggota extends StatelessWidget {
  static const routeName = '/detail-anggota';

  const DetailAnggota({super.key});

  @override
  Widget build(BuildContext context) {
    final anggotas = Provider.of<Anggotas>(context, listen: false);
    final anggotaId = ModalRoute.of(context)!.settings.arguments as String;
    final selectAnggota = anggotas.selectById(anggotaId);

    final TextEditingController nimController =
        TextEditingController(text: selectAnggota.nim);
    final TextEditingController namaController =
        TextEditingController(text: selectAnggota.nama);
    final TextEditingController alamatController =
        TextEditingController(text: selectAnggota.alamat);
    final TextEditingController jenisKelaminController =
        TextEditingController(text: selectAnggota.jenis_kelamin);

    return Scaffold(
      appBar: AppBar(
        title: const Text("DETAIL ANGGOTA"),
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
                textInputAction: TextInputAction.done,
                controller: jenisKelaminController,
                onEditingComplete: () {
                  anggotas.editAnggota(
                    anggotaId,
                    nimController.text,
                    namaController.text,
                    alamatController.text,
                    jenisKelaminController.text,
                    context,
                  );
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 50),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    anggotas.editAnggota(
                      anggotaId,
                      nimController.text,
                      namaController.text,
                      alamatController.text,
                      jenisKelaminController.text,
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
