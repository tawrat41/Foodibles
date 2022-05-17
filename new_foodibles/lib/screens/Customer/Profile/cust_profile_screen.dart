import 'package:flutter/material.dart';
import 'package:new_foodibles/CustAppDrawer_screen.dart';

class CustProfilePage extends StatefulWidget {
  // const CustProfilePage({ Key? key }) : super(key: key);

  @override
  _CustProfilePageState createState() => _CustProfilePageState();
}

class _CustProfilePageState extends State<CustProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      drawer: CustAppDrawer(),
      body: Text("body"),
    );
  }
}
