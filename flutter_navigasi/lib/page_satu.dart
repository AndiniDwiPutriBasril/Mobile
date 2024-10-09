import 'package:flutter/material.dart';
import 'package:flutter_navigasi/page_dua.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return PageDua(); // Ensure PageDua is correctly defined and imported
            }),
          );
        },
        child: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
