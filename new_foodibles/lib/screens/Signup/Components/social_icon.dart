import 'package:flutter/material.dart';

import '../../../constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconText;
  const SocialIcon({
    Key key,
    this.iconText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: alternateColor,
        ),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          iconText,
          style: TextStyle(color: alternateColor),
        ),
      ),
    );
  }
}
