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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 40,
              color: Colors.green,
            ),
            Container(
              width: 100,
              height: 40,
              color: Colors.yellow,
            ),
            Container(
              width: 200,
              height: 40,
              color: Colors.red,
            ),
            Container(
              width: 200,
              height: 40,
              color: Colors.black,
            ),
          ],
          )
      ),
    );
  }
}