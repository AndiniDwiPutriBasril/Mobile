class Anggota {
  final String kodeAnggota;
  final String nama;
  final String alamat;

  Anggota({
    required this.kodeAnggota,
    required this.nama,
    required this.alamat,
  });

  Map<String, dynamic> toMap() {
    return {
      'kodeAnggota': kodeAnggota,
      'nama': nama,
      'alamat': alamat,
    };
  }

  factory Anggota.fromMap(Map<String, dynamic> map) {
    return Anggota(
      kodeAnggota: map['kodeAnggota'],
      nama: map['nama'],
      alamat: map['alamat'],
    );
  }
}
