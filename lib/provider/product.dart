import 'package:ecommerce_app/models/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<List<Products>> {
  ProductNotifier() : super([]);

  void setProducts(List<Products> products) {
    state = products;
  }

  void toggleFavourite(int productId) {
    var productIndex = state.indexWhere((element) => element.id == productId);
    state[productIndex].isFavourite = !state[productIndex].isFavourite!;
    state = List.from(state);
  }

  List<Products> get favourites {
    return state.where((element) => element.isFavourite!).toList();
  }

}

final productProvider = StateNotifierProvider<ProductNotifier, List<Products>>(
    (ref) => ProductNotifier());
