import 'package:flutter/material.dart';

class RestOptionTiles extends StatelessWidget {
  final String imageDirectory;
  final String title;
  final String goToScreenRoute;
  const RestOptionTiles({
    Key key,
    this.imageDirectory,
    this.title,
    this.goToScreenRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size.width * 0.35,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, goToScreenRoute);
          },
          child: Stack(
            // alignment: Alignment.center,
            children: <Widget>[
              GridTile(
                child: Image.asset(
                  imageDirectory,
                  height: size.height * 0.27,
                  width: size.width * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: size.height * 0.03,
                // right: 10,
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.01),
                  alignment: Alignment.center,
                  color: Colors.black54,
                  width: size.width * 0.35,
                  // width: 300,

                  // alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      // backgroundColor: Colors.black38,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
