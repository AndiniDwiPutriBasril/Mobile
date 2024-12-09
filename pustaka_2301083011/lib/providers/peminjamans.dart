import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/peminjaman.dart';

class Peminjamans with ChangeNotifier {
  final List<Peminjaman> _allPeminjaman = [];

  List<Peminjaman> get allPeminjaman => _allPeminjaman;

  int get jumlahPeminjaman => _allPeminjaman.length;

  Peminjaman selectById(String id) {
    return _allPeminjaman.firstWhere((element) => element.id == id);
  }

  Future<void> addPeminjaman(String tanggal_pinjam, String tanggal_kembali, String anggota_id, String buku_id) async {
    Uri url = Uri.parse("http://localhost/pustaka_2301083011/API/peminjaman.php");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "tanggal_pinjam": tanggal_pinjam,
          "tanggal_kembali": tanggal_kembali,
          "anggota_id": anggota_id,
          "buku_id": buku_id,
        }),
      );

      print("THEN FUNCTION");
      print(json.decode(response.body));

      final peminjaman = Peminjaman(
        id: json.decode(response.body)["id"],
        tanggal_pinjam: tanggal_pinjam,
        tanggal_kembali: tanggal_kembali,
        anggota_id: int.parse(anggota_id),
        buku_id: int.parse(buku_id),
      );

      _allPeminjaman.add(peminjaman);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  void editPeminjaman(
    String id,
    String tanggal_pinjam,
    String tanggal_kembali,
    String anggota_id,
    String buku_id,
    BuildContext context,
  ) {
    Peminjaman selectPeminjaman =
        _allPeminjaman.firstWhere((element) => element.id == id);
    selectPeminjaman.tanggal_pinjam = tanggal_pinjam;
    selectPeminjaman.tanggal_kembali = tanggal_kembali;
    selectPeminjaman.anggota_id = int.parse(anggota_id);
    selectPeminjaman.buku_id = int.parse(buku_id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deletePeminjaman(String id, BuildContext context) {
    _allPeminjaman.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301083011/API/peminjaman.php");
    try {
      var hasilGetData = await http.get(url);
      var dataResponse = json.decode(hasilGetData.body) as Map<String, dynamic>;

      // Create Student objects from the response data
      final List<Peminjaman> loadedPeminjaman = [];
      dataResponse.forEach((key, value) {
        loadedPeminjaman.add(
          Peminjaman(
            id: value['id'],
            tanggal_pinjam: value['tanggal_pinjam'],
            tanggal_kembali: value['tanggal_kembali'],
            anggota_id: value['anggota_id'],
            buku_id: value['buku_id'],
          ),
        );
      });

      _allPeminjaman.clear();
      _allPeminjaman.addAll(loadedPeminjaman);

      print("BERHASIL MEMUAT DATA LIST");
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }
}
