class Pengembalian {
  int id;
  String tanggal_pengembalian;
  String terlambat;
  String denda;
  int peminjaman_id;

  Pengembalian({
    required this.id, 
    required this.tanggal_pengembalian, 
    required this.terlambat, 
    required this.denda,
    required this.peminjaman_id
    });

}