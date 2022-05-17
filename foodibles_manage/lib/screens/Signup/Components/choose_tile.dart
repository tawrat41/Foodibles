import 'package:flutter/material.dart';

class ChooseTile extends StatelessWidget {
  final String title;
  final String imageDirectory;
  final Widget toScreen;

  const ChooseTile({
    Key key,
    this.title,
    this.imageDirectory,
    this.toScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return toScreen;
          }),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: size.width * 0.4,
          height: size.height * 0.5,
          child: GridTile(
            child: Image.asset(
              imageDirectory,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              title: Text(title),
              backgroundColor: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }
}
