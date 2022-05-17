import 'package:flutter/material.dart';
import 'package:foodibles_manage/screens/Business/Board_Status/busi_status_board_screen.dart';
import 'package:foodibles_manage/screens/Business/Homepage/busi_homepage_screen.dart';
import 'package:foodibles_manage/screens/Business/Menu/busi_menu_screen.dart';
import 'package:foodibles_manage/screens/Login/login_screen.dart';
import 'package:foodibles_manage/screens/Signup/business_details_screen.dart';
import 'package:foodibles_manage/screens/Signup/signup_screen.dart';
import 'package:foodibles_manage/screens/Welcome/welcome_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routesInTheme() {
    return {
      WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
      LoginScreen.routeName: (ctx) => LoginScreen(),
      SignupScreen.routeName: (context) => SignupScreen(),
      BusinessDetailsScreen.routeName: (context) => BusinessDetailsScreen(),
      BusiHomeScreen.routeName: (context) => BusiHomeScreen(),
      BusiMenuScreen.routeName: (context) => BusiMenuScreen(),
      BusiStatusBoard.routeName: (context) => BusiStatusBoard(),
      // RestHomePage.routeName: (context) => RestHomePage(),
      // AddFoodScreen.routeName: (context) => AddFoodScreen(),

      // custHome: (context) => CustHomePage(),
    };
  }
}
