import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imagePath;     // Local image path
  final String productName;   // Product name
  final double productPrice;  // Product price

  ProductCard({
    required this.imagePath,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap if you want to navigate to a detail page
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),  // Display local image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                productName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '\$${productPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
