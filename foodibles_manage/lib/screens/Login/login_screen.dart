import 'package:flutter/material.dart';
import 'package:foodibles_manage/Components/bypass_login_signup.dart';
import 'package:foodibles_manage/Components/rounded_button.dart';
import 'package:foodibles_manage/Components/rounded_input_field.dart';
import 'package:foodibles_manage/constants.dart';
import 'package:foodibles_manage/screens/Signup/signup_screen.dart';

import '../../authentication_service.dart';
import '../../main.dart';
// import 'package:foodibles_manage/constants.dart';

class LoginScreen extends StatelessWidget {
  String email = '', password = '';
  final AuthenticationService _auth = AuthenticationService();
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.04),
              Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              RoundedInputField(
                hint: 'Email',
                icon: Icons.person,
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedInputField(
                hint: 'Password',
                icon: Icons.lock,
                obscure: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              RoundedButton(
                text: "Login",
                press: () async {
                  // dynamic result= await _auth.signInAnonimously();

                  dynamic result = await _auth.signIn(
                    email: email,
                    password: password,
                  );
                  if (result == null) {
                    print("error");
                  } else {
                    print("signed in");
                    print(result.uid);
                    // final firebaseRef = FirebaseDatabase.instance.reference();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AuthenticationWrapper();
                      }),
                    );
                  }
                },
                color: alternateColor,
              ),
              SizedBox(height: size.height * 0.02),
              BypassSignupLogin(
                text: "Don't have an acoount?  ",
                goTo: 'Signup',
                screen: SignupScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
