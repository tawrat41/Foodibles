import 'package:flutter/material.dart';
import 'package:new_foodibles/screens/Customer/Homepage/cust_homepage.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/HomePage/rest_homepage_screen.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/RatingsPage/cust_ratings_screen.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/StatusPage/rest_status_page.dart';
import 'package:new_foodibles/screens/Login/login_screen.dart';
import 'package:new_foodibles/screens/Signup/signup_screen.dart';
import 'package:new_foodibles/screens/Welcome/welcome_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routesInTheme() {
    return {
      WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
      LoginScreen.routeName: (ctx) => LoginScreen(),
      SignupScreen.routeName: (context) => SignupScreen(),
      CustHomePage.routeName: (context) => CustHomePage(),
      // RestHomePage.routeName: (context) => RestHomePage(),
      CustRatingPage.routeName: (context) => CustRatingPage(),
      StatusPage.routeName: (context) => StatusPage(),

      // AddFoodScreen.routeName: (context) => AddFoodScreen(),

      // custHome: (context) => CustHomePage(),
    };
  }
}
