import 'package:flutter/material.dart';
import 'package:flutter_dialog/MyHomepage.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: MyHomepage(),
    );
  }
}
