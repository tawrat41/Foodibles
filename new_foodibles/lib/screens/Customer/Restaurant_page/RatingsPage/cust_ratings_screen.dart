import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_foodibles/Theme/restaurantID.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/StatusPage/rest_status_page.dart';
import 'package:provider/provider.dart';

class CustRatingPage extends StatefulWidget {
  static const routeName = '/ratings-page';

  @override
  State<CustRatingPage> createState() => _CustRatingPageState();
}

class _CustRatingPageState extends State<CustRatingPage> {
  Future<void> _future;
  List reviews = [];
  final fieldText = TextEditingController();
  // final Future<FirebaseApp> _future = Firebase.initializeApp();
  @override
  void initState() {
    setState(() {
      _future = fetchRating(context);
      fetchReview(context);
    });

    super.initState();
  }

  // @override
  fetchReview(BuildContext context) async {
    // await Firebase.initializeApp();
    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;
    final firebaseRef = FirebaseDatabase.instance.reference();
    firebaseRef
        .child("restaurants/$restId/reviews")
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) reviews = dataSnapshot.value;
      // print(reviews);
      // print(reviews[0].toString());
    });
  }

  int totalRating = 0;
  int rates = 0;
  int currentRating = 0;

  Future<void> fetchRating(BuildContext context) async {
    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;
    final firebaseRef = FirebaseDatabase.instance.reference();
    await firebaseRef
        .child("restaurants/$restId/ratingDetails")
        .once()
        .then((DataSnapshot dataSnapshot) {
      totalRating = dataSnapshot.value['total-rating'];
      rates = dataSnapshot.value['rates'];
    });
    print(totalRating);
    print(rates);
  }

  void submitRating(BuildContext context, int rating) {
    // final firebaseUser = Provider.of<User>(context);
    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;
    final firebaseRef = FirebaseDatabase.instance.reference();
    firebaseRef.child("restaurants/$restId/ratingDetails").update({
      'total-rating': totalRating,
      'rates': rates,
    });
    fetchRating(context);
  }

  void submitReview(BuildContext context, String review) {
    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;

    final firebaseRef = FirebaseDatabase.instance.reference();
    firebaseRef
        .child("restaurants/$restId/reviews")
        .once()
        .then((DataSnapshot dataSnapshot) {
      // print(dataSnapshot.value);
      reviews = dataSnapshot.value;
      // print(reviews);
      // print(reviews[0].toString());
    });
    setState(() {
      reviews.add(review);
    });
    firebaseRef.child("restaurants/$restId/").update({
      'reviews': reviews,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _currentIndex = 2;

    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;

    return Scaffold(
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
                    Navigator.pop(context);
                    break;
                  }
                case 1:
                  {
                    Navigator.popAndPushNamed(
                      context,
                      StatusPage.routeName,
                    );
                    break;
                  }
                case 2:
                  {
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
        title: Text("Ratings Page"),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child("restaurants/$restId/")
                  .once()
                  .asStream(),
              builder: (context, snapshot) {
                return Container(
                  height: size.height * 0.75,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                // color: Colors.blue,
                                width: size.width * 0.4,
                                height: size.height * 0.2,
                                child: CircleAvatar(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          double.parse((totalRating / rates)
                                                  .toStringAsFixed(2))
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Text(rates.toString() + " People Rated",
                                          style:
                                              TextStyle(color: Colors.black54)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Container(
                                // width: size.width * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Rate Now!",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    StarRatingWidget((rating) {
                                      currentRating = rating;
                                      print(currentRating);
                                      setState(() {
                                        totalRating = totalRating + rating;
                                        rates += 1;
                                        submitRating(context, rating);
                                      });
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reviews",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (reviews.length != 0)
                          for (int i = 0; i < reviews.length; i++)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Person " + (i + 1).toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(reviews[i].toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                      ],
                    ),
                  ),
                );
              }),
          Container(
            // color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                color: Color.fromRGBO(246, 246, 246, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              // color: Colors.white,Food
              child: TextFormField(
                controller: fieldText,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Write a review',
                  border: InputBorder.none,
                ),
                onFieldSubmitted: (value) {
                  submitReview(context, value);
                  fieldText.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRatingWidget extends StatefulWidget {
  final Function(int) onRatingSelected;
  StarRatingWidget(this.onRatingSelected);

  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  Widget _buildRatingStar(int index) {
    if (index < currentRating) {
      return Icon(Icons.star, color: Colors.orange);
    } else {
      return Icon(Icons.star_border_outlined);
    }
  }

  int currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(5, (index) {
        return GestureDetector(
          child: _buildRatingStar(index),
          onTap: () {
            setState(() {
              currentRating = index + 1;
            });
            // print(currentRating);
            this.widget.onRatingSelected(currentRating);
          },
        );
      }),
    );
  }
}
