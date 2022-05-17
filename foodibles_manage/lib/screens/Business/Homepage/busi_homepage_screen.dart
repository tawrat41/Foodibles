// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:foodibles_manage/Components/rest_option_tile.dart';
import 'package:foodibles_manage/AppDrawer_screen.dart';
import 'package:foodibles_manage/screens/Business/Board_Status/busi_status_board_screen.dart';
import 'package:foodibles_manage/screens/Business/Menu/busi_menu_screen.dart';

class BusiHomeScreen extends StatelessWidget {
  static const routeName = '/busi_homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Restaurant"),
      ),
      drawer: AppDrawer(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RestOptionTiles(
                title: "Update Menu",
                imageDirectory: 'assets/images/menu.jpg',
                goToScreenRoute: BusiMenuScreen.routeName,
              ),
              RestOptionTiles(
                title: "Update Status",
                imageDirectory: 'assets/images/status.jpg',
                goToScreenRoute: BusiStatusBoard.routeName,
              ),
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     // RestOptionTiles(
          //     //   title: "Update Status",imageDirectory: ,goToScreenRoute: ,
          //     // ),
          //     // RestOptionTiles(
          //     //   title: "Update Status",imageDirectory: ,goToScreenRoute: ,
          //     // ),
          //   ],
          // )
        ],
      ),
    );
  }
}
