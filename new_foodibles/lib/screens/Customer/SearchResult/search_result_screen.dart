import 'package:flutter/material.dart';
import 'package:new_foodibles/screens/Customer/Restaurant_page/HomePage/rest_homepage_screen.dart';

class RestSearchResultScreen extends StatelessWidget {
  final List searchResults;
  RestSearchResultScreen(this.searchResults);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: AppBar(
        title: Text("Search results"),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchResults.length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                // Provider.of<RestIdProvider>(context, listen: false).restId = searchResults[index].key;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestHomePage(searchResults[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  // color: Color.fromRGBO(229, 229, 229, 1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        CircleAvatar(
                          child: Text("R"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              searchResults[index]['name'],
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              searchResults[index]['address'],
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Spacer(),
                        Text(
                          searchResults[index]['description'],
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Text(index.toString())
          ),
        ],
      ),
    );
  }
}
