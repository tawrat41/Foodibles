import 'package:flutter/material.dart';
import 'package:foodibles_manage/Theme/FoodItem.dart';
import 'package:foodibles_manage/screens/Business/Menu/edit_fooditem_screen.dart';
import 'package:provider/provider.dart';

class FoodRow extends StatelessWidget {
  const FoodRow({
    Key key,
    @required this.categoryName,
    this.index,
  }) : super(key: key);

  final String categoryName;
  final int index;

  @override
  Widget build(BuildContext context) {
    final foodData = Provider.of<FoodItem>(context);
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Food searchedFood = foodData.getFoods(categoryName)[index];
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return EditFoodItemPage(
                  categoryOfFood: categoryName,
                  food: searchedFood,
                );
              }),
            );
          },
          child: Container(
            child: Row(
              children: <Widget>[
                if (foodData.getFoods(categoryName)[index].imageDirectory !=
                    null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            foodData
                                .getFoods(categoryName)[index]
                                .imageDirectory,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      foodData.getFoods(categoryName)[index].name,
                      style: TextStyle(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4, top: 4),
                      child: Text(
                        foodData.getFoods(categoryName)[index].quantityType,
                        style: TextStyle(fontSize: 10, color: Colors.black38),
                      ),
                    ),
                  ],
                ),
                new Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    '${foodData.getFoods(categoryName)[index].price.toInt().toString()}৳',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
