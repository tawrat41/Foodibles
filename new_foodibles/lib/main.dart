import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Theme/FoodItem.dart';
import 'Theme/cart.dart';
import 'Theme/category.dart';
import 'Theme/order.dart';
import 'Theme/restaurantID.dart';
import 'Theme/routes.dart';
import 'Theme/user.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';
import 'screens/Welcome/welcome_screen.dart';

import 'screens/Customer/Homepage/cust_homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //important for firebase authentication
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ), //this provides authentication service
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => RestIdProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryOfFoods(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FoodItem(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
        //within the create service, we access the authentication service with this
        //checking if we are logged in or not
      ],
      child: MaterialApp(
        title: 'Auth',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AuthenticationWrapper(),
        routes: AppRoutes.routesInTheme(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);

    //if logged in, get the user
    final firebaseRef = FirebaseDatabase.instance.reference();
    var data = new Map();
    if (firebaseUser != null) {
      print(firebaseUser.uid);

      return CustHomePage();
    }
    return WelcomeScreen();
  }
}
