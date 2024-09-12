import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce App"),
      ),
      body: ProductsGrid(),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2, // Number of columns
            itemCount: products.length, // Number of items in the grid
            itemBuilder: (context, index) {
              var product = products[index];
              return ProductTile(
                imageUrl: product['imageUrl'],
                title: product['title'],
                price: product['price'],
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1), // Tile configuration
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        );
      },
    );
  }
}

class ProductTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;

  ProductTile({required this.imageUrl, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
