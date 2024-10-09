import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext) {
    //TODO : implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My App"),
        ),
        body: Stack(
          children: [
            Container(
              width: 400,
              height: 400,
              color: Colors.green,
            ),
            Container(
              width: 300,
              height: 300,
              color: Colors.yellow,
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.red,
            ),
            Container(
              width: 100,
              height:100,
              color: Colors.black,
            ),
          ],
          )
      ),
    );
  }
}