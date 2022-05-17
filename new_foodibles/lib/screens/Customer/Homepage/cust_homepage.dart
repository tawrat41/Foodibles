import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_foodibles/Theme/cart.dart';
import 'package:new_foodibles/screens/Customer/SearchResult/search_result_screen.dart';
import 'package:provider/provider.dart';

import '../../../CustAppDrawer_screen.dart';

class CustHomePage extends StatefulWidget {
  static const routeName = '/customer-homepage';

  @override
  _CustHomePageState createState() => _CustHomePageState();
}

class _CustHomePageState extends State<CustHomePage> {
  final fieldText = TextEditingController();

  Map newRest;
  var restaurantName = "";
  void searchRestaurant(String restaurantName) {
    List searchResults = [];

    final firebaseRef = FirebaseDatabase.instance.reference();
    firebaseRef.child("restaurants/").once().then((DataSnapshot dataSnapshot) {
      dataSnapshot.value.forEach((restaurant, values) {
        if (dataSnapshot.value[restaurant]['name'] == restaurantName) {
          var restaurantData = dataSnapshot.value[restaurant];
          print("kaj kore == $restaurantData");
          searchResults.add(restaurantData);
        }
      });
    }).then((value) {
      if (searchResults.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestSearchResultScreen(searchResults),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: CustAppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 247, 1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 10),
                Icon(Icons.search),
                SizedBox(width: 10),
                Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: fieldText,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: 'Search for Restaurants',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      setState(
                        () {
                          Provider.of<Cart>(context, listen: false)
                              .clear_cart();
                          restaurantName = value;
                          print("value = $value");
                          searchRestaurant(value);
                        },
                      );
                      fieldText.clear();
                    },
                  ),
                ),
                // FlatButton(
                //   onPressed: () {},
                //   child: Text("Search"),
                // ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.yellow,
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                    child: GridTile(
                      child: Image.asset(
                        'assets/images/scan.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.yellow,
                    width: size.width * 0.4,
                    height: size.height * 0.2,
                    child: GridTile(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1526367790999-0150786686a2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=871&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Spacer(),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text("© Foodibles 2022"),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
