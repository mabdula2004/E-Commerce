import 'package:e_commerce/product_grid/product_grid.dart';
import 'package:e_commerce/sample_products/sample_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model/cart_model.dart';
import 'cart_screen/cart_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('E-commerce'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
            ),
          ],
        ),
        body: ProductGrid(products: sampleProducts),
      ),
    );
  }
}
