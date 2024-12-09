import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pengembalian.dart';

class Pengembalians with ChangeNotifier {
  final List<Pengembalian> _allPengembalian = [];

  List<Pengembalian> get allPengembalian => _allPengembalian;

  int get jumlahPengembalian => _allPengembalian.length;

  Pengembalian selectById(String id) {
    return _allPengembalian.firstWhere((element) => element.id == id);
  }

  Future<void> addPengembalian(String tanggal_pengembalian, String denda, String terlambat, String peminjaman_id) async {
    Uri url = Uri.parse("http://localhost/pustaka_2301083011/API/pengembalian.php");

    try {
      final response = await http.post(
        url,
        body: json.encode({
          "tanggal_pengembalian": tanggal_pengembalian,
          "denda": denda,
          "terlambat": terlambat,
          "peminjaman_id": peminjaman_id,
        }),
      );

      print("THEN FUNCTION");
      print(json.decode(response.body));

      final pengembalian = Pengembalian(
        id: json.decode(response.body)["id"],
        tanggal_pengembalian: tanggal_pengembalian,
        denda: denda,
        terlambat: terlambat,
        peminjaman_id: int.parse(peminjaman_id),
      );

      _allPengembalian.add(pengembalian);
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  void editPengembalian(
    String id,
    String tanggal_pengembalian,
    String denda,
    String terlambat,
    String peminjaman_id,
    BuildContext context,
  ) {
    Pengembalian selectPengembalian =
        _allPengembalian.firstWhere((element) => element.id == id);
    selectPengembalian.tanggal_pengembalian = tanggal_pengembalian;
    selectPengembalian.denda = denda;
    selectPengembalian.terlambat = terlambat;
    selectPengembalian.peminjaman_id = int.parse(peminjaman_id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  void deletePengembalian(String id, BuildContext context) {
    _allPengembalian.removeWhere((element) => element.id == id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil dihapus"),
        duration: Duration(milliseconds: 500),
      ),
    );
    notifyListeners();
  }

  Future<void> initializeData() async {
    Uri url = Uri.parse("http://localhost/pustaka_2301083011/API/pengembalian.php");
    try {
      var hasilGetData = await http.get(url);
      List<dynamic> dataResponse = json.decode(hasilGetData.body);

      // Konversi data response ke List<Pengembalian>
      final List<Pengembalian> loadedPengembalian = dataResponse.map((item) => 
        Pengembalian(
          id: int.parse(item['id'].toString()),
          tanggal_pengembalian: item['tanggal_pengembalian'],
          denda: item['denda'],
          terlambat: item['terlambat'],
          peminjaman_id: int.parse(item['peminjaman_id']),
        )
      ).toList();

      _allPengembalian.clear();
      _allPengembalian.addAll(loadedPengembalian);

      print("BERHASIL MEMUAT DATA PENGEMBALIAN");
      notifyListeners();
    } catch (err) {
      print("Error: $err");
      rethrow;
    }
  }
}
