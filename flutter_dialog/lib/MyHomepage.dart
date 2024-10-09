import 'package:flutter/material.dart';

class MyHomepage extends StatefulWidget {
  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  String data = "Belum ada input";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dialog"),
      ),
      body: Center(
        child: Text(
          data,
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Telah Di Klik");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("OK"),
                content: const Text("Apakah dihapus?"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        data = "TRUE";
                      });
                    },
                    child: const Text("YES"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        data = "FALSE";
                      });
                    },
                    child: const Text("NO"),
                  ),
                ],
              );
            },
          ).then((value) => print("value"));
        },
        child: const Icon(Icons.delete),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Huruf kecil
    );
  }
}