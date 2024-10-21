import 'package:ecommerce_app/models/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifer extends StateNotifier<List<Products>> {
  CartNotifer() : super([]);

  void addProduct(Products product) {
    state.add(product);
    state = List.from(state);
  }

  void removeProduct(Products product) {
    List<Products> temp = List.from(state);
    temp.remove(product);
    state = temp;
  }

  void clearfromCart(int productId) {
    state.removeWhere((element) => element.id == productId);
    state = List.from(state);
  }

  double get totalPrice {
    return state.fold(
        0, (previousValue, element) => previousValue + element.price!);
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifer, List<Products>>((ref) => CartNotifer());
