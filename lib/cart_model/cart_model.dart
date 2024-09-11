import 'package:flutter/material.dart';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.fold(0.0, (sum, product) => sum + product.price);
  }
}
