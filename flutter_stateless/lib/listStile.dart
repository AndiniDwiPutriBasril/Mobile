import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("List Title"),
        ),
        body: ListView(
          children: const [
            ListTile(
              title: Text("Salsabila putri sonia"),
              subtitle: Text("This is subtitle okay.."),
              leading: CircleAvatar(),
              trailing: Text("10:00 PM"),
            ),
            ListTile(
              title: Text("Rosi maltasari"),
              subtitle: Text("This is subtitle okay.."),
              leading: CircleAvatar(),
              trailing: Text("12:00 PM"),
            ),
          ],
        ),
      ),
    );

  }
}