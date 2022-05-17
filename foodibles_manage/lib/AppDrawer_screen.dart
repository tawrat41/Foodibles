import 'package:flutter/material.dart';

import 'authentication_service.dart';
import 'screens/Business/Homepage/busi_homepage_screen.dart';
import 'screens/Business/Orders_page/busi_orders_screen.dart';
import 'screens/Welcome/welcome_screen.dart';

class AppDrawer extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();

  //  AppDrawer({
  //   Key key,
  // }) : _auth = auth, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false, //disabling the back button
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => BusiHomeScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
          Divider(
              // color: Colors.yellow,
              ),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text('Orders'),
            onTap: () {
              // Navigator.of(context).pop(); // close the drawer

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BusiOrderScreen();
                }),
              );
            },
          ),
          Divider(),
          Expanded(child: Container()),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return WelcomeScreen();
                }),
              ); // close the drawer

              _auth.signOut();
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
