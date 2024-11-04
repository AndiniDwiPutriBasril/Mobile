import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class HttpProvider  with ChangeNotifier{
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  int get jumlahData => _data.length;

  void connectAPI(String name, String job) async {
   Uri url = Uri.parse("https://reqres.in/api/users"); 

    var hasilResponse = await http.post(
      url,
      body: {
        "name" : name,
        "job" : job,
      },
    );

    _data = json.decode(hasilResponse.body);
    notifyListeners();
  }
}