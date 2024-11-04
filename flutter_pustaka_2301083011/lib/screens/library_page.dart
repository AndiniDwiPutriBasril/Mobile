import 'package:flutter/material.dart';

class Buku {
  final String judul;
  final String penulis;
  final String gambarUrl;
  final String sinopsis;
  final String tahunTerbit;
  final String penerbit;
  final int jumlahHalaman;

  Buku({
    required this.judul,
    required this.penulis,
    required this.gambarUrl,
    required this.sinopsis,
    required this.tahunTerbit,
    required this.penerbit,
    required this.jumlahHalaman,
  });
}

final daftarBuku = [
  Buku(
    judul: 'Mariposa',
    penulis: 'Luluk HF',
    gambarUrl: 'assets/images/mariposa.jpg',
    sinopsis:
        'Acha, gadis yang terjebak dalam dilema cinta segitiga antara Iqbal dan Ken. Kisah ini mengajarkan tentang arti persahabatan, cinta, dan pengorbanan. Mariposa mengisahkan perjalanan mereka menemukan makna cinta yang sesungguhnya.',
    tahunTerbit: '2018',
    penerbit: 'Coconut Books',
    jumlahHalaman: 496,
  ),
  Buku(
    judul: 'Dilan 1990',
    penulis: 'Pidi Baiq',
    gambarUrl: 'assets/images/dilan.jpg',
    sinopsis:
        'Kisah cinta Dilan dan Milea di tahun 1990, yang dimulai dengan cara Dilan yang unik dalam mendekati Milea. Novel ini menceritakan romantisme anak SMA dengan gaya yang segar dan menghibur.',
    tahunTerbit: '2014',
    penerbit: 'Pastel Books',
    jumlahHalaman: 332,
  ),
  // ... tambahkan buku lainnya dengan detail yang sama
];

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan'),
        backgroundColor: const Color(0xFFFFC0CB),
      ),
      body: Container(
        color: const Color(0xFFFFF0F5),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: daftarBuku.length,
          itemBuilder: (context, index) {
            final buku = daftarBuku[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              color: const Color(0xFFFFF5F7),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            buku.gambarUrl,
                            width: 120,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 120,
                              height: 180,
                              color: Colors.grey[300],
                              child: const Icon(Icons.book, size: 50),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buku.judul,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Penulis: ${buku.penulis}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Penerbit: ${buku.penerbit}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Tahun Terbit: ${buku.tahunTerbit}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Jumlah Halaman: ${buku.jumlahHalaman}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Sinopsis:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      buku.sinopsis,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
