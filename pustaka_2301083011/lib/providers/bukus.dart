import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/buku.dart';

class Bukus with ChangeNotifier {
  final List<Buku> _allBuku = [];

  List<Buku> get allBuku => _allBuku;

  int get jumlahBuku => _allBuku.length;

  Buku selectById(String id) {
    return _allBuku.firstWhere((element) => element.id == id);
  }

  Future<void> addBuku(String kode_buku, String judul, String pengarang, String penerbit, String tahun_terbit) async {
    Uri url = Uri.parse("http://localhost/pustaka_2301083011/API/buku.php");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "kode_buku": kode_buku,
          "judul": judul,
          "pengarang": pengarang,
          "penerbit": penerbit,
          "tahun_terbit": tahun_terbit,
        }),
      );

      print("THEN FUNCTION");
      print(json.decode(response.body));

      final buku = Buku(
        id: json.decode(response.body)["id"],
        kode_buku: kode_buku,
        judul: judul,
        pengarang: pengarang,
        penerbit: penerbit,
        tahun_terbit: tahun_terbit,
      );

      _allBuku.add(buku);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  void editBuku(
    String id,
    String kode_buku,
    String judul,
    String pengarang,
    String penerbit,
    String tahun_terbit,
    BuildContext context,
  ) {
    Buku selectBuku =
        _allBuku.firstWhere((element) => element.id == id);
    selectBuku.kode_buku = kode_buku;
    selectBuku.judul = judul;
    selectBuku.pengarang = pengarang;
    selectBuku.penerbit = penerbit;
    selectBuku.tahun_terbit = tahun_terbit;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deleteBuku(String id, BuildContext context) {
    _allBuku.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301083011/API/buku.php");
    try {
      var hasilGetData = await http.get(url);
      List<dynamic> dataResponse = json.decode(hasilGetData.body);

      // Konversi data response ke List<Buku>
      final List<Buku> loadedBuku = dataResponse.map((item) => 
        Buku(
          id: item['id'].toString(),
          kode_buku: item['kode_buku'],
          judul: item['judul'],
          pengarang: item['pengarang'],
          penerbit: item['penerbit'],
          tahun_terbit: item['tahun_terbit'],
        )
      ).toList();

      _allBuku.clear();
      _allBuku.addAll(loadedBuku);

      print("BERHASIL MEMUAT DATA BUKU");
      notifyListeners();
    } catch (err) {
      print("Error: $err");
      rethrow;
    }
  }
}
