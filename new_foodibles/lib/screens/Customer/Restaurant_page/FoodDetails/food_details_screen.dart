import 'package:flutter/material.dart';
import 'package:new_foodibles/Theme/cart.dart';
import 'package:provider/provider.dart';

class FoodDetailsScreen extends StatefulWidget {
  static const routeName = '/food-details-page';

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
  final Map foodData;
  FoodDetailsScreen(this.foodData);
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int order = 1;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodData['name']),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: size.width,
                height: 200,
                color: Colors.blue,
                child: Image.network(
                  widget.foodData['imageUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Text(
                    widget.foodData['name'],
                    style: TextStyle(fontSize: 30),
                  ),
                  Spacer(),
                  Text(
                    "${widget.foodData['price'].toString()} taka",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red[900],
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 13),
                  Text("${widget.foodData['description'].toString()}"),
                ],
              ),
              SizedBox(height: 10),

              Divider(),
              // Text("Quant"),
            ],
          ),
          Positioned(
            bottom: 20,
            child: Container(
              // color: Colors.blue[50],
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (order > 1)
                            setState(() {
                              order--;
                            });
                        },
                        color: Colors.orangeAccent,
                        icon: Icon(Icons.remove_circle, size: 30),
                      ),
                      Text(
                        order.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            order++;
                          });
                        },
                        color: Colors.orangeAccent,
                        icon: Icon(Icons.add_circle, size: 30),
                      ),
                    ],
                  ),

                  // Spacer(),
                  Container(
                    // color: Colors.blue[50],
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      child: Text(
                        "Add to cart",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        cartProvider.addItem(
                          widget.foodData['name'],
                          widget.foodData['price'],
                          order,
                        );
                        print(cartProvider.items);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
