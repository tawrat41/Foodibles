// Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: !imageSubmitted
              //       ? MainAxisAlignment.start
              //       : MainAxisAlignment.center,
              //   children: <Widget>[
              //     Container(
              //       height: size.height * 0.25,
              //       width: size.height * 0.25,
              //       margin: EdgeInsets.only(top: 8, right: 10),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           width: 1,
              //           color: Colors.grey,
              //         ),
              //       ),
              //       child: !imageSubmitted
              //           ? GestureDetector(
              //               onTap: () {
              //                 _imgFromGallery();
              //                 // Navigator.of(context).pop();
              //               },
              //               child: Stack(
              //                 // alignment: Alignment.center,
              //                 children: <Widget>[
              //                   Align(
              //                     alignment: Alignment.topCenter,
              //                     child: Icon(
              //                       Icons.add,
              //                       size: 130,
              //                       color: Colors.blue,
              //                     ),
              //                   ),
              //                   Positioned(
              //                     // bottom: 0,
              //                     // right: 10,
              //                     child: Container(
              //                       padding: EdgeInsets.all(size.width * 0.01),
              //                       alignment: Alignment.bottomLeft,
              //                       color: Colors.black12,
              //                       child: Text(
              //                         "Click to choose from gallery",
              //                         style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 14,
              //                           backgroundColor: Colors.white12,
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             )
              //           : Align(
              //               alignment: Alignment.center,
              //               child: ClipRRect(
              //                 // borderRadius: BorderRadius.circular(5),
              //                 child: Container(
              //                   height: 100,
              //                   width: 100,
              //                   child: Image.file(
              //                     File(_image.path),
              //                     width: 100,
              //                     height: 100,
              //                     fit: BoxFit.fitHeight,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //     ),
              //   ],
              // ),