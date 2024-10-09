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
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 500,
              height: 500,
              color: Colors.green,
            ),
            Container(
              width: 500,
              height: 500,
              color: Colors.yellow,
            ),
            Container(
              width: 500,
              height: 500,
              color: Colors.red,
            ),
            Container(
              width: 500,
              height:500,
              color: Colors.black,
            ),
          ],
          )
      ),
    );
  }
}