// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodibles_manage/Components/rounded_button.dart';
import 'package:foodibles_manage/constants.dart';
import 'package:foodibles_manage/screens/Login/login_screen.dart';
import 'package:foodibles_manage/screens/Signup/signup_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      // color: Colors.yellowAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  "Welcome To",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Foodibles ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Manage",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          RoundedButton(
            text: 'LOGIN',
            press: () {
              // Navigator.of(context).pushNamed(LoginScreen.routeName);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }),
              );
            },
          ),
          RoundedButton(
            text: 'SIGNUP',
            press: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     return SignupScreen();
              //   }),
              // );
              Navigator.pushNamed(context, SignupScreen.routeName);
            },
            color: alternateColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
