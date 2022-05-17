import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final int tableNo = 1;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List _orders = [];
  List _custOrders = [];

  String orderId = '';
  final firebaseRef = FirebaseDatabase.instance.reference();

  BuildContext context;

  Orders();

  List get orders {
    return [..._orders];
  }

  List get custOrders {
    return [..._custOrders];
  }

  fetchOrders(BuildContext context) async {
    // orders.clear();

    final userId = Provider.of<User>(context, listen: false).uid;
    print(userId);
    final firebaseRef = FirebaseDatabase.instance.reference();
    await firebaseRef
        .child("restaurants/$userId/orders")
        .once()
        .then((DataSnapshot dataSnapshot) {
      print(dataSnapshot.value);
      _orders.clear();

      dataSnapshot.value.forEach((custId, value) {
        dataSnapshot.value[custId].forEach((orderId, value2) {
          print("order ${dataSnapshot.value[custId][orderId]}");
          _orders.add(dataSnapshot.value[custId][orderId]);
        });
      });
    });
    await print(_orders);
    notifyListeners();

    return "_orders";
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total,
      String userId, String restID) async {
    final timeStamp = DateTime.now();
    orderId =
        firebaseRef.child("foodies/$userId/orders/").push().key.toString();
    print(orderId);
    firebaseRef.child("foodies/$userId/orders/$orderId/").set({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(),
      'products': cartProducts
          .map((cp) => {
                // 'id': cp.id,
                'title': cp.title,
                'quantity': cp.quantity,
                'price': cp.price,
              })
          .toList(),
    });
    firebaseRef.child("restaurants/$restID/orders/$userId/$orderId/").set({
      'amount': total,
      'dateTime': timeStamp.toIso8601String(),
      'products': cartProducts
          .map((cp) => {
                // 'id': cp.id,
                'title': cp.title,
                'quantity': cp.quantity,
                'price': cp.price,
              })
          .toList(),
    });

    _orders.insert(
      0,
      OrderItem(
        id: orderId,
        amount: total,
        dateTime: timeStamp,
        products: cartProducts,
      ),
    );
    print("orders ${_orders}");
    notifyListeners();
  }

  Future<List> custFetchOrders(BuildContext context) async {
    // _custOrders.clear();

    final userId = Provider.of<User>(context, listen: false).uid;
    // print(userId);
    final firebaseRef = FirebaseDatabase.instance.reference();
    await firebaseRef
        .child("foodies/$userId/orders")
        .once()
        .then((DataSnapshot dataSnapshot) {
      _custOrders.clear();
      // print(dataSnapshot.value);

      dataSnapshot.value.forEach((orderId, value2) {
        // print("order ${dataSnapshot.value[orderId]}");
        _custOrders.add(dataSnapshot.value[orderId]);
      });
    });
    return _custOrders;
    // print(_custOrders);

    notifyListeners();
  }
}
