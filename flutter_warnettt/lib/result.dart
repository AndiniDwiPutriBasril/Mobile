import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String kodePelanggan;
  final String namaPelanggan;
  final String jenisPelanggan;
  final String tglMasuk;
  final int jamMasuk;
  final int jamKeluar;

  const ResultPage({
    required this.kodePelanggan,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
  });

  @override
  Widget build(BuildContext context) {
    int tarifPerJam = 10000;
    int lama = (jamKeluar - jamMasuk) ~/ 60;
    double diskon = 0;

    if (jenisPelanggan == "VIP" && lama > 2) {
      diskon = 0.02 * tarifPerJam * lama;
    } else if (jenisPelanggan == "GOLD" && lama > 2) {
      diskon = 0.05 * tarifPerJam * lama;
    }

    double totalBayar = (lama * tarifPerJam) - diskon;

    return Scaffold(
      appBar: AppBar(
        title: Text('Total Hasil '),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Pelanggan: $kodePelanggan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Nama Pelanggan: $namaPelanggan',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Jenis Pelanggan: $jenisPelanggan',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Tanggal Masuk: $tglMasuk',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Jam Masuk: ${jamMasuk ~/ 60}:${jamMasuk % 60}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Jam Keluar: ${jamKeluar ~/ 60}:${jamKeluar % 60}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lama Waktu: $lama jam',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Tarif/Jam: Rp$tarifPerJam',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Diskon: Rp${diskon.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total Bayar: Rp${totalBayar.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
