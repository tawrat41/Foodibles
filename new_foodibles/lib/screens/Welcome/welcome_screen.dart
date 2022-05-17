import 'package:flutter/material.dart';

import 'body.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-page';

  // const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
