class Buku {
  final String kodeBuku;
  final String judul;
  final String pengarang;
  final String penerbit;
  final String tahunTerbit;

  Buku({
    required this.kodeBuku,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.tahunTerbit,
  });

  Map<String, dynamic> toMap() {
    return {
      'kodeBuku': kodeBuku,
      'judul': judul,
      'pengarang': pengarang,
      'penerbit': penerbit,
      'tahunTerbit': tahunTerbit,
    };
  }

  factory Buku.fromMap(Map<String, dynamic> map) {
    return Buku(
      kodeBuku: map['kodeBuku'],
      judul: map['judul'],
      pengarang: map['pengarang'],
      penerbit: map['penerbit'],
      tahunTerbit: map['tahunTerbit'],
    );
  }
} 