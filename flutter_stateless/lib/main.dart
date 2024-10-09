import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        body: const Center(
          child: Text("Andini Dwiputri Basril ",
          //maxLines : 2,
          //overFlow : TextOferFlow . ellipsis,
          style : TextStyle(
            backgroundColor : Colors.amber,
            color: Colors.white,
            fontSize: 30
          ),),
      ),//center
    ),
    );
  }
}