import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:flutter_model/models/produk.dart';
class HomePage extends StatelessWidget {
  final Faker faker = Faker();

  HomePage({super.key});

@override
  Widget build(BuildContext context) {
    List<Produk> data = List.generate(100, (index) {
      return Produk(
        "https://picsum.photos/id/$index/200/300",
        faker.food.restaurant(),
        10000 + Random().nextInt(100000),
        faker.lorem.sentence(),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Model"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GridTile(
            child: img.Image.network(data[index].imageUrl),
            footer: Container(
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data[index].nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp ${data[index].harga}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    data[index].desc,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
} 