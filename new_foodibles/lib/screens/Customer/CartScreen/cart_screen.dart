import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_foodibles/Theme/cart.dart';
import 'package:new_foodibles/Theme/order.dart';
import 'package:new_foodibles/Theme/restaurantID.dart';
import 'package:new_foodibles/Theme/user.dart';
import 'package:new_foodibles/screens/Customer/CartScreen/cart_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<Cart>(context); // here we have to update the full widget
    //except for the appbar
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(), // takes as much as space
                Chip(
                  label: Text(
                    '৳${cartProvider.totalAmount.toStringAsFixed(2)}',
                    // style: TextStyle(
                    // color: Theme.of(context).primaryTextTheme.title.color),
                  ), // to show of the money
                  // backgroundColor: Theme.of(context).primaryColor,
                ),
                OrderButton(cart: cartProvider),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.itemCount,
              itemBuilder: (ctx, i) => CartItemWidget(
                // cartProvider[i].id,
                cartProvider.items.keys
                    .toList()[i], // this gives out the product id
                cartProvider.items.values.toList()[i].price,
                cartProvider.items.values.toList()[i].quantity,
                cartProvider.items.values.toList()[i].title,
                //because cart.items is a map, but we need list of the values
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    print(DateTime.now().toString());
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              String uid = Provider.of<User>(context, listen: false).uid;
              print("uuuuuuuuuuuuu isssssss $uid");
              String restID =
                  Provider.of<RestIdProvider>(context, listen: false).restId;
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
                uid,
                restID,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear_cart();
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
