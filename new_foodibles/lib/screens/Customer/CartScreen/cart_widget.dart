import 'package:flutter/material.dart';
import 'package:new_foodibles/Theme/cart.dart';
import 'package:provider/provider.dart';
// import 'package:restaurant_app/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  // final String productId;
  final int price;
  final int quantity;
  final String title;
  CartItemWidget(
    this.id,
    // this.productId,
    this.price,
    this.quantity,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    //dismissible is for the swipe effect on cart item
    return Dismissible(
      key: ValueKey(id), //just pass any unique thing as constructor

      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('DO you want to remove the item from your Cart?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                  //false:we dont want to confirm the dismiss
                  //this will close the dialog which will return something that confirmdismis needs
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  //false:we want to confirm the dismiss/delete
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(title);
        //we are removing through the product id we have
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: FittedBox(child: Text('৳$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: ৳${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
