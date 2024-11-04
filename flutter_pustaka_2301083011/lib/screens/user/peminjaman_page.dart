import 'package:flutter/material.dart';
import '../../models/anggota.dart';
import '../../models/buku.dart';
import '../../widgets/custom_text_field.dart';
import 'detail_peminjaman_page.dart';

class PeminjamanPage extends StatefulWidget {
  const PeminjamanPage({super.key});

  @override
  State<PeminjamanPage> createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final _formKey = GlobalKey<FormState>();
  final _kodeAnggotaController = TextEditingController();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _kodeBukuController = TextEditingController();
  final _judulController = TextEditingController();
  final _pengarangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Peminjaman Buku'),
        backgroundColor: Color(0xFFFFB6C1),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Data Anggota',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Kode Anggota',
                controller: _kodeAnggotaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Kode anggota harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Nama Lengkap',
                controller: _namaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Alamat',
                controller: _alamatController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Alamat harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Data Buku',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Kode Buku',
                controller: _kodeBukuController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Kode buku harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Judul Buku',
                controller: _judulController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Judul buku harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Pengarang',
                controller: _pengarangController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Pengarang harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: const Size(150, 45),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB6C1),
                      minimumSize: const Size(150, 45),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final anggota = Anggota(
                          kodeAnggota: _kodeAnggotaController.text,
                          nama: _namaController.text,
                          alamat: _alamatController.text,
                        );

                        final buku = Buku(
                          kodeBuku: _kodeBukuController.text,
                          judul: _judulController.text,
                          pengarang: _pengarangController.text,
                          penerbit: '-',
                          tahunTerbit: '-',
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPeminjamanPage(
                              anggota: anggota,
                              buku: buku,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _kodeAnggotaController.dispose();
    _namaController.dispose();
    _alamatController.dispose();
    _kodeBukuController.dispose();
    _judulController.dispose();
    _pengarangController.dispose();
    super.dispose();
  }
}
