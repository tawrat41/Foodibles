import 'package:flutter/material.dart';
import 'package:new_foodibles/Theme/order.dart';
import 'package:provider/provider.dart';

class CustOrderScreen extends StatefulWidget {
  List orders = [];

  @override
  _CustOrderScreenState createState() => _CustOrderScreenState();
}

class _CustOrderScreenState extends State<CustOrderScreen> {
  Future<void> _future;

  @override
  void initState() {
    setState(() {
      _future =
          Provider.of<Orders>(context, listen: false).custFetchOrders(context);
      widget.orders = Provider.of<Orders>(context, listen: false).custOrders;
      // print("lalaal ${widget.orders}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting)
              return SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      for (int i = 0; i < widget.orders.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.blue[50],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Date: ${widget.orders[i]['dateTime'].substring(0, 10)}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    // Spacer(),
                                    Text(
                                      "At: ${widget.orders[i]['dateTime'].substring(11, 19)}",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                for (int j = 0;
                                    j < widget.orders[i]['products'].length;
                                    j++)
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 10),
                                      Text(
                                        widget.orders[i]['products'][j]
                                            ['title'],
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Spacer(),
                                      Text(
                                          "${widget.orders[i]['products'][j]['price']} x ${widget.orders[i]['products'][j]['quantity']}"),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                SizedBox(height: 20),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Spacer(),
                                    Text("Total ="),
                                    SizedBox(width: 10),
                                    Align(
                                      // alignment: Alignment.centerRight,
                                      child: Text(
                                        widget.orders[i]['amount'].toString(),
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      // Text("data"),
                    ],
                  ),
                ),
              );
            else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
