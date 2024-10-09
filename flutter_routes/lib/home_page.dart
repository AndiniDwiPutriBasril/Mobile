import 'package:flutter/material.dart';
import 'package:flutter_routes/gallery_page.dart'; // Ensure this path is correct

class HomePage extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text(
          'Home Page',
          style: TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return GalleryPage(); // Ensure GalleryPage is correctly defined and imported
            },
          ));
        },
        child: Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
