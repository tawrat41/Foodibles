import 'package:flutter/material.dart';

import 'authentication_service.dart';
import 'screens/Customer/Homepage/cust_homepage.dart';
import 'screens/Customer/Orders/cust_orders_screen.dart';

class CustAppDrawer extends StatelessWidget {
  CustAppDrawer({
    Key key,
  }) : super(key: key);

  final AuthenticationService _auth = AuthenticationService();

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
              Navigator.of(context)
                  .pushReplacementNamed(CustHomePage.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CustOrderScreen();
                }),
              );
            },
          ),
          Divider(),
          Expanded(child: Container()),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              // close the drawer
              Navigator.of(context)
                  .restorablePushNamed('/'); //return to home screen
              _auth.signOut();
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
