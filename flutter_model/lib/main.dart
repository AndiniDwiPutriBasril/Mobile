import 'package:flutter/material.dart';
import 'package:flutter_model/pages/home_page.dart';


void main(){
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}