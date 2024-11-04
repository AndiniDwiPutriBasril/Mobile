import 'package:flutter/material.dart';
import '../../models/buku.dart';
import '../../widgets/custom_text_field.dart';

class KelolaBukuPage extends StatefulWidget {
  const KelolaBukuPage({super.key});

  @override
  State<KelolaBukuPage> createState() => _KelolaBukuPageState();
}

class _KelolaBukuPageState extends State<KelolaBukuPage> {
  final List<Buku> _daftarBuku = [];
  final _formKey = GlobalKey<FormState>();
  final _kodeBukuController = TextEditingController();
  final _judulController = TextEditingController();
  final _pengarangController = TextEditingController();
  final _penerbitController = TextEditingController();
  final _tahunController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Buku'),
        backgroundColor: Color(0xFFFFC0CB),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _daftarBuku.length,
              itemBuilder: (context, index) {
                final buku = _daftarBuku[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(buku.judul),
                    subtitle: Text('${buku.pengarang} - ${buku.tahunTerbit}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _daftarBuku.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFC0CB),
        onPressed: () {
          _showTambahBukuDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTambahBukuDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Buku'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  label: 'Judul',
                  controller: _judulController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Judul harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Pengarang',
                  controller: _pengarangController,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Penerbit',
                  controller: _penerbitController,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFFC0CB),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _daftarBuku.add(
                    Buku(
                      kodeBuku: _kodeBukuController.text,
                      judul: _judulController.text,
                      pengarang: _pengarangController.text,
                      penerbit: _penerbitController.text,
                      tahunTerbit: _tahunController.text,
                    ),
                  );
                });

                _kodeBukuController.clear();
                _judulController.clear();
                _pengarangController.clear();
                _penerbitController.clear();
                _tahunController.clear();

                Navigator.pop(context);
              }
            },
            child: const Text(
              'Simpan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
