import 'package:flutter/material.dart';
import 'package:foodibles_manage/Theme/FoodItem.dart';
import 'package:foodibles_manage/Theme/category.dart';
import 'package:foodibles_manage/constants.dart';
import 'package:foodibles_manage/screens/Business/AddFood/add_food_screen.dart';
import 'package:provider/provider.dart';

import 'FoodRowTile.dart';

class RestCategoryTile extends StatefulWidget {
  final CategoryClass category_for_tile;

  const RestCategoryTile(this.category_for_tile);

  @override
  _RestCategoryTileState createState() => _RestCategoryTileState();
}

class _RestCategoryTileState extends State<RestCategoryTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final foodData = Provider.of<FoodItem>(context);
    String categoryName = widget.category_for_tile.name.toString();
    // final categoryData = Provider.of<CategoryOfProducts>(context);

    return Card(
      elevation: 5,
      shadowColor: kPrimarylightColor,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.category_for_tile.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print(widget.category_for_tile.name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddFoodScreen(widget.category_for_tile.name),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.lightBlue[50],
                      borderOnForeground: false,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            color: kPrimaryColor,
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          ),
                          Text('Lets add a FOOD item!'),
                        ],
                      ),
                    ),
                  ),
                  if (foodData.foodInCategories.containsKey(categoryName))
                    Divider(),
                  if (foodData.foodInCategories.containsKey(categoryName))
                    Consumer<FoodItem>(
                      builder: (ctx, foodData, child) =>
                          Column(children: <Widget>[
                        for (var j = 0;
                            j < foodData.getFoods(categoryName).length;
                            j++)
                          FoodRow(
                            categoryName: categoryName,
                            index: j,
                          ),
                      ]),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
