import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Theme/restaurantID.dart';
import '../RatingsPage/cust_ratings_screen.dart';

class StatusPage extends StatefulWidget {
  static const routeName = '/status-page';
  StatusPage({Key key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  int _currentIndex = 1;
  String status = '';

  Future<String> fetchStatus(BuildContext context) async {
    final restId = Provider.of<RestIdProvider>(context, listen: false).restId;

    final firebaseRef = FirebaseDatabase.instance.reference();
    await firebaseRef
        .child("restaurants/$restId/status")
        .once()
        .then((DataSnapshot dataSnapshot) {
      status = dataSnapshot.value['status'];
      print(status);

      return dataSnapshot.value['status'].toString;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await fetchStatus(context);
    });
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
                    break;
                  }
                case 2:
                  {
                    Navigator.popAndPushNamed(
                      context,
                      CustRatingPage.routeName,
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
        title: Text("Status"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/status_black.jpg"),
              FutureBuilder<String>(
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting)
                    return Text(
                      status,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  else
                    return CircularProgressIndicator();
                },
                future: fetchStatus(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
