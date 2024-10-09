import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer Navigation',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Drawer"),
    ),
    drawer: Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Menu Pilihan", style: TextStyle(fontSize: 24),),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PageSatu(),));
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          )
        ],
      ),
    ),
    );
      
  
  }
}



class PageSatu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: Center(
        child: Text("Ini Page 1"),
      ),      
    );
  }
}