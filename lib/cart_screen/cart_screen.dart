import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.cart.length,
        itemBuilder: (context, index) {
          final product = cart.cart[index];
          return ListTile(
            leading: Image.network(product.imageUrl, width: 50),
            title: Text(product.name),
            subtitle: Text('\$${product.price}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                cart.removeFromCart(product);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Total: \$${cart.totalPrice}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
