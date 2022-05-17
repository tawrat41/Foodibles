import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodibles_manage/AppDrawer_screen.dart';
import 'package:foodibles_manage/Theme/FoodItem.dart';
// import 'package:foodibles_manage/Theme/FoodItem.dart';
import 'package:foodibles_manage/Theme/category.dart';
import 'package:provider/provider.dart';

import 'RestCategoryTile.dart';

class BusiMenuScreen extends StatefulWidget {
  static const routeName = '/menu-screen';
  Future<void> waitForProducts(BuildContext context) async {
    final firebaseUser = Provider.of<User>(context, listen: false);
    await Provider.of<FoodItem>(context, listen: false)
        .fetchAndSetFoods(firebaseUser, context);
    print("done");
  }

  @override
  _BusiMenuScreenState createState() => _BusiMenuScreenState();
}

class _BusiMenuScreenState extends State<BusiMenuScreen> {
  Future<void> _future;
  @override
  void initState() {
    _future = widget.waitForProducts(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context);
    // widget._waitForProducts(context);

    Size size = MediaQuery.of(context).size;
    final categoryData = Provider.of<CategoryOfFoods>(context);
    final foodData = Provider.of<FoodItem>(context);
    // print("hehe");

    // print("screen ${Provider.of<FoodItem>(context).foodInCategories}");
    String categoryName = "aaaR";

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            highlightColor: Colors.white,
            splashColor: Colors.blue,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    // width: size.width * 0.9,
                    child: AlertDialog(
                      title: Text("Add a new Category"),
                      content: SizedBox(
                        height: size.height * 0.3,
                        child: Column(
                          children: <Widget>[
                            TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'New Category',
                              ),
                              onChanged: (value) {
                                categoryName = value;
                              },
                              // maxLines: 1,
                            ),
                            FlatButton(
                              child: Text("Add"),
                              onPressed: () {
                                print(categoryName);
                                if (categoryData.categoryExists(categoryName)) {
                                  print("You already have that category");
                                } else {
                                  foodData.addCategory(categoryName);
                                  categoryData.addCategory(
                                    CategoryClass(name: categoryName),
                                  );
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);

                                  // print("hoise");
                                  // print(categoryData.categories);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _future,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<FoodItem>(
                    builder: (ctx, categoryData, _) => Scrollbar(
                      interactive: true,
                      child: ListView.builder(
                        itemCount: categoryData.categoryNames.length,
                        itemBuilder: (_, i) => RestCategoryTile(
                            CategoryClass(name: categoryData.categoryNames[i])),
                      ),
                    ),
                  ),
      ),
    );
  }
}


// FutureBuilder(
//         future: widget._waitForProducts(context),
//         builder: (ctx, snapshot) =>
//             snapshot.connectionState == ConnectionState.waiting
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : RefreshIndicator(
//                     onRefresh: () => widget._waitForProducts(context),
//                     child: 



// Consumer<CategoryOfFoods>(
//                     builder: (ctx, categoryData, _) => Scrollbar(
//                       interactive: true,
//                       child: ListView.builder(
//                         itemCount: categoryData.categories.length,
//                         itemBuilder: (_, i) =>
//                             RestCategoryTile(categoryData.categories[i]),
//                       ),
//                     ),
//                   ),