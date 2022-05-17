import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_foodibles/CustAppDrawer_screen.dart';
import 'package:new_foodibles/Theme/restaurantID.dart';
import 'package:new_foodibles/screens/Customer/CartScreen/cart_screen.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/FoodDetails/food_details_screen.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/RatingsPage/cust_ratings_screen.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/StatusPage/rest_status_page.dart';
import 'package:provider/provider.dart';

class RestHomePage extends StatefulWidget {
  final Map restData;
  static const routeName = '/restaurant-homepage';
  RestHomePage(this.restData);

  @override
  State<RestHomePage> createState() => _RestHomePageState();
}

class _RestHomePageState extends State<RestHomePage> {
  String status = '';

  Future<void> fetchStatus(BuildContext context) async {
    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;

    final firebaseRef = FirebaseDatabase.instance.reference();
    await firebaseRef
        .child("restaurants/$restId/status")
        .once()
        .then((DataSnapshot dataSnapshot) {
      status = dataSnapshot.value['status'];
      print(status);
    });
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    Future _future;
    List categories = [];
    Provider.of<RestIdProvider>(context, listen: false).restId =
        widget.restData['id'];
    print(Provider.of<RestIdProvider>(context, listen: false).restId);

    widget.restData['menu'].keys.forEach((key) {
      categories.add(key.toString());
    });
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      bottomNavigationBar: BottomNavigationBar(
        // iconSize: 30,

        // backgroundColor: Color.fromRGBO(103, 97, 152, 1),
        // unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
              switch (index) {
                case 0:
                  {
                    break;
                  }
                case 1:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return StatusPage();
                        },
                      ),
                    );
                    break;
                  }
                case 2:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CustRatingPage();
                        },
                      ),
                    );
                    break;
                  }
                default:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CustRatingPage();
                        },
                      ),
                    );
                    break;
                  }
              }
            },
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'New!',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Ratings & Reviews',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.restData['name']),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CartScreen();
                }),
              );
            },
          )
        ],
      ),
      drawer: CustAppDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: 150,
                    color: Colors.yellow,
                    child: Image.network(
                      "https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1778&q=80",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          color: Colors.black54,
                          child: Text(
                            "  Delivery in 30 minutes  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   right: 2,
                  //   top: 120,
                  //   // alignment: Alignment.bottomRight,
                  //   child: Text(
                  //     "About",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              // Divider(),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20),
                    for (int i = 0; i < categories.length; i++)
                      Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: Icon(Icons.food_bank),
                              ),
                              SizedBox(height: 5),
                              Text(categories[i]),
                            ],
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (ctx, mapIndex) {
                      List foods = [];
                      // print(restData['menu'][categories[mapIndex]]);
                      widget.restData['menu'][categories[mapIndex]].keys
                          .forEach((food) {
                        // print(food);
                        foods.add(food.toString());
                      });

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categories[mapIndex],
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: foods.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5 / 6,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 20,
                                ),
                                itemBuilder: (context, i) {
                                  return Container(
                                    color: Colors.yellow,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            print(widget.restData['menu']
                                                    [categories[mapIndex]]
                                                [foods[i]]);
                                            return FoodDetailsScreen(
                                                widget.restData['menu']
                                                        [categories[mapIndex]]
                                                    [foods[i]]);
                                          }),
                                        );
                                      },
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Image.network(
                                                widget.restData['menu']
                                                        [categories[mapIndex]]
                                                    [foods[i]]['imageUrl'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    foods[i],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Price: " +
                                                        "${widget.restData['menu'][categories[mapIndex]][foods[i]]['price'].toString()} taka",
                                                    style: TextStyle(
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 15),

                            // for (int i = 0; i < foods.length; i++)
                            //   GestureDetector(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(builder: (context) {
                            //           print(widget.restData['menu']
                            //               [categories[mapIndex]][foods[i]]);
                            //           return FoodDetailsScreen(
                            //               widget.restData['menu']
                            //                   [categories[mapIndex]][foods[i]]);
                            //         }),
                            //       );
                            //     },
                            //     child: Card(
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(6.0),
                            //         child: Row(
                            //           children: <Widget>[
                            //             SizedBox(
                            //               width: 50,
                            //               child: ClipOval(
                            //                 child: Image.network(
                            //                   widget.restData['menu']
                            //                           [categories[mapIndex]]
                            //                       [foods[i]]['imageUrl'],
                            //                   fit: BoxFit.cover,
                            //                   height: 40,
                            //                 ),
                            //               ),
                            //             ),
                            //             SizedBox(width: 10),
                            //             Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: <Widget>[
                            //                 Text(
                            //                   foods[i],
                            //                   style: TextStyle(
                            //                     fontWeight: FontWeight.w600,
                            //                     fontSize: 18,
                            //                   ),
                            //                 ),
                            //                 Text(
                            //                   "${widget.restData['menu'][categories[mapIndex]][foods[i]]['price'].toString()} taka",
                            //                   style: TextStyle(
                            //                       color: Colors.grey[500]),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
