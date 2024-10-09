import 'package:flutter/material.dart';
import 'package:flutter_warnettt/result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warnet App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Tambahkan font custom jika diperlukan
      ),
      home: EntryPage(),
    );
  }
}

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController kodePelangganController = TextEditingController();
  TextEditingController namaPelangganController = TextEditingController();
  TextEditingController tglMasukController = TextEditingController();
  TextEditingController jamMasukController = TextEditingController();
  TextEditingController jamKeluarController = TextEditingController();
  String? jenisPelanggan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warnet Entry Page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Menggunakan Card untuk membungkus form agar terlihat lebih menarik
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Menggunakan Icon pada input field
                        buildTextFormField(
                          controller: kodePelangganController,
                          label: 'Kode Pelanggan',
                          icon: Icons.code,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kode pelanggan harus diisi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        buildTextFormField(
                          controller: namaPelangganController,
                          label: 'Nama Pelanggan',
                          icon: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nama pelanggan harus diisi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: jenisPelanggan,
                          decoration: InputDecoration(
                            labelText: 'Jenis Pelanggan',
                            prefixIcon: Icon(Icons.group),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: <String>['VIP', 'GOLD', 'REGULAR']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              jenisPelanggan = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Jenis pelanggan harus dipilih';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        buildTextFormField(
                          controller: tglMasukController,
                          label: 'Tanggal Masuk (DD/MM/YYYY)',
                          icon: Icons.calendar_today,
                        ),
                        SizedBox(height: 10),
                        buildTextFormField(
                          controller: jamMasukController,
                          label: 'Jam Masuk (HH:MM)',
                          icon: Icons.access_time,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Jam masuk harus diisi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        buildTextFormField(
                          controller: jamKeluarController,
                          label: 'Jam Keluar (HH:MM)',
                          icon: Icons.access_time_filled,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Jam keluar harus diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    List<String> jamMasukParts =
                        jamMasukController.text.split(':');
                    List<String> jamKeluarParts =
                        jamKeluarController.text.split(':');
                    int jamMasuk = int.parse(jamMasukParts[0]) * 60 +
                        int.parse(jamMasukParts[1]);
                    int jamKeluar = int.parse(jamKeluarParts[0]) * 60 +
                        int.parse(jamKeluarParts[1]);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          kodePelanggan: kodePelangganController.text,
                          namaPelanggan: namaPelangganController.text,
                          jenisPelanggan: jenisPelanggan!,
                          tglMasuk: tglMasukController.text,
                          jamMasuk: jamMasuk,
                          jamKeluar: jamKeluar,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat TextFormField dengan styling yang lebih menarik
  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
