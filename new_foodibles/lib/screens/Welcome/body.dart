import 'package:flutter/material.dart';
import 'package:new_foodibles/Components/rounded_button.dart';
import 'package:new_foodibles/Theme/routes.dart';
import 'package:new_foodibles/constants.dart';
import 'package:new_foodibles/screens/Login/login_screen.dart';
import 'package:new_foodibles/screens/Signup/signup_screen.dart';

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
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Welcome To Foodibles",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
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
