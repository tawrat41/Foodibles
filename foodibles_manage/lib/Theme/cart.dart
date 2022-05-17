import 'package:flutter/cupertino.dart';

class CartItem {
  // final String id;
  final String title;
  final int quantity;
  final int price;

  CartItem({
    // @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String title, int price, int quant) {
    if (_items.containsKey(title)) {
      _items.update(
        title,
        (existingCartItem) => CartItem(
          // id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        title,
        () => CartItem(
          // id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: quant,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String title) {
    _items.remove(title);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return; //if it doesnt exist, dont do anything
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingProductId) => CartItem(
          // id: existingProductId.id,
          title: existingProductId.title,
          quantity: existingProductId.quantity - 1,
          price: existingProductId.price,
        ), //if quant > 1 lowering quant, otherwise deleting
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear_cart() {
    _items = {};
    notifyListeners();
  }
}
