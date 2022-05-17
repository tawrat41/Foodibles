// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusiStatusBoard extends StatefulWidget {
  static const routeName = '/status-board';

  @override
  State<BusiStatusBoard> createState() => _BusiStatusBoardState();
}

class _BusiStatusBoardState extends State<BusiStatusBoard> {
  var status = "";

  void updateStatus(String status, String userid) {
    final firebaseRef = FirebaseDatabase.instance.reference();

    firebaseRef.child("restaurants/$userid/status").update({
      'status': status,
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/status_black.jpg"),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          height: 200,
                          width: size.width * 0.85,
                          // color: Colors.blueAccent[100],
                          alignment: Alignment.center,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText: '  Type Your New Status',
                                  // labelStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  status = value;
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    // print("value = $value");
                    // print(firebaseUser.uid);
                    updateStatus(status, firebaseUser.uid);
                    Navigator.pop(context);
                  },
                );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
