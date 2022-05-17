import 'package:flutter/material.dart';

import '../constants.dart';

class BypassSignupLogin extends StatelessWidget {
  final Widget screen;
  final String text;
  final String goTo;
  const BypassSignupLogin({
    Key key,
    this.screen,
    this.text,
    this.goTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: alternateColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return screen;
              }),
            );
          },
          child: Text(
            goTo,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
