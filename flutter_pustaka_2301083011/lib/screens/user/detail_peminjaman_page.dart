import 'package:flutter/material.dart';
import '../../models/anggota.dart';
import '../../models/buku.dart';

class DetailPeminjamanPage extends StatelessWidget {
  final Anggota anggota;
  final Buku buku;

  const DetailPeminjamanPage({
    super.key,
    required this.anggota,
    required this.buku,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Peminjaman'),
        backgroundColor: Color(0xFFFFC0CB),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              'Data Anggota',
              [
                'Kode Anggota: ${anggota.kodeAnggota}',
                'Nama: ${anggota.nama}',
                'Alamat: ${anggota.alamat}',
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              'Data Buku',
              [
                'Kode Buku: ${buku.kodeBuku}',
                'Judul: ${buku.judul}',
                'Pengarang: ${buku.pengarang}',
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailCard(
              'Informasi Peminjaman',
              [
                'Tanggal Pinjam: ${DateTime.now().toString().split(' ')[0]}',
                'Batas Pengembalian: ${DateTime.now().add(const Duration(days: 7)).toString().split(' ')[0]}',
                'Status: Dipinjam',
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFC0CB),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Kembali ke halaman awal
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Selesai'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<String> details) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              children: details.map((detail) {
                return Text(detail);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
