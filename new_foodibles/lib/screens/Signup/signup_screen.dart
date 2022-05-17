import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_foodibles/Components/bypass_login_signup.dart';
import 'package:new_foodibles/Components/rounded_button.dart';
import 'package:new_foodibles/Components/rounded_input_field.dart';
import 'package:new_foodibles/Theme/funtion_for_navigation.dart';
import 'package:new_foodibles/authentication_service.dart';
import 'package:new_foodibles/constants.dart';
import 'package:new_foodibles/screens/Login/login_screen.dart';
import 'package:new_foodibles/screens/Signup/customer_details_screen.dart';
// import 'package:provider/provider.dart';

import 'Components/or_divider.dart';
import 'Components/social_icon.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signUp';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = ' ', password = ' ';

  final AuthenticationService _auth = AuthenticationService();
  // TextEditingController _emailController;
  // TextEditingController _passwordController;
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            // key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.08),
                Text(
                  "SIGNUP",
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
                    setState(() {
                      email = value;
                    });
                  },
                ),
                RoundedInputField(
                  hint: 'Password',
                  icon: Icons.lock,
                  obscure: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                RoundedButton(
                  text: "SIGNUP",
                  color: alternateColor,
                  press: () async {
                    // print(email);
                    // print(password);

                    User result = (await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    ))
                        .user;
                    if (result == null) {
                      print("error");
                    } else {
                      print("signed up");
                      print(result.uid);
                      goToScreen(context, CustomerDetailsScreen());
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
                BypassSignupLogin(
                  text: "Already have an account?  ",
                  goTo: 'Login',
                  screen: LoginScreen(),
                ),
                SizedBox(height: size.height * 0.02),
                OrDivider(),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SocialIcon(
                      iconText: "FB",
                    ),
                    SocialIcon(
                      iconText: "G",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
