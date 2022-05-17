import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FoodItem extends ChangeNotifier {
  final firebaseRef = FirebaseDatabase.instance.reference();

  Map foodInCategories = new Map<String, List>();
  List<String> categoryNames = [];

  void addCategory(String category) {
    categoryNames.add(category);
    notifyListeners();
  }

  List<Food> getFoods(String categoryName) {
    return [...foodInCategories[categoryName]];
  }

  void addFood(String categoryName, Food food, User user) {
    if (foodInCategories.containsKey(categoryName)) {
      if (foodInCategories[categoryName]
              .firstWhere((cat) => cat.name == food.name, orElse: () => null) !=
          null) {
        print(
            "Food already exists.Try adding different food with different name");
      } else {
        final newFood = Food(
          name: food.name,
          price: food.price,
          description: food.description,
          quantityType: food.quantityType,
          imageDirectory: food.imageDirectory,
        );
        firebaseRef
            .child("restaurants/${user.uid}/menu/$categoryName/${food.name}")
            .set({
          'name': food.name,
          'price': food.price,
          'description': food.description,
          'quantityType': food.quantityType,
          'imageUrl': food.imageDirectory,

          // 'image': food.image,
        });
        List<Food> foods = foodInCategories[categoryName];
        foods.add(newFood);
        foodInCategories[categoryName] = foods;
        notifyListeners();
      }
    } else {
      final newFood = Food(
        // id: food.id,
        name: food.name,
        price: food.price,
        description: food.description,
        quantityType: food.quantityType,
        imageDirectory: food.imageDirectory,

        // imageDirectory: food.imageDirectory,
      );
      firebaseRef
          .child("restaurants/${user.uid}/menu/$categoryName/${food.name}")
          .set({
        'name': food.name,
        'price': food.price,
        'description': food.description,
        'quantityType': food.quantityType,
        'imageUrl': food.imageDirectory,
        // 'image': food.image,
      });
      List<Food> foods = [newFood];
      foodInCategories[categoryName] = foods;
      notifyListeners();
    }
  }

  bool firstLoad(int loaded) {
    loaded = 1;
  }

  Future<void> fetchAndSetFoods(User user, BuildContext context) async {
    categoryNames.clear();
    foodInCategories.clear();

    print(user.uid);
    await firebaseRef.child("restaurants/${user.uid}/menu/").once().then(
      (DataSnapshot dataSnapshot) {
        // var categories = dataSnapshot.value.keys;
        print("all cats= ${dataSnapshot.value}");
        dataSnapshot.value.forEach((categories, foods) {
          print(categories);
          print("foods in cat = ${dataSnapshot.value[categories]}");
          List<Food> foods = [];

          dataSnapshot.value[categories].forEach((food, details) {
            print("Foods now $food");
            print("details ${dataSnapshot.value[categories][food]}");
            final newFood = Food(
              name: dataSnapshot.value[categories][food]['name'],
              price: dataSnapshot.value[categories][food]['price'].toDouble(),
              description: dataSnapshot.value[categories][food]['description'],
              quantityType: dataSnapshot.value[categories][food]
                  ['quantityType'],
              imageDirectory: dataSnapshot.value[categories][food]['imageUrl'],
            );
            foods.add(newFood);
            print("new food $newFood");
          });
          print("list of foods $foods");
          print(categories.toString());
          foodInCategories[categories.toString()] = foods;
          // Provider.of<CategoryOfFoods>(context, listen: false)
          //     .addCategory(CategoryClass(name: categories.toString()));
          categoryNames.add(categories.toString());
          print("foods $foodInCategories");
          // print(
          //     Provider.of<CategoryOfFoods>(context, listen: false).categories);
        });
      },
    );
    notifyListeners();
  }

  Food findByName(String categoryName, String foodName) {
    return foodInCategories[categoryName]
        .firstWhere((food) => food.name == foodName);
  }

  bool foodExists(String categoryName, String foodName) {
    if (foodInCategories[categoryName]
            .firstWhere((food) => food.name == foodName, orElse: () => null) ==
        null) {
      return false; //food doesnt exist
    } else {
      return true; //already exists in this category
    }
  }

  Future<void> updateFoodItem(BuildContext context, String category,
      Food newFoodItem, Food oldFood) async {
    final firebaseUser = Provider.of<User>(context, listen: false);

    firebaseRef
        .child("restaurants/${firebaseUser.uid}/menu/$category/${oldFood.name}")
        .set({
      'name': newFoodItem.name,
      'price': newFoodItem.price,
      'description': newFoodItem.description,
      'quantityType': newFoodItem.quantityType,
      'imageUrl': newFoodItem.imageDirectory,

      // 'image': food.image,
    });

    // _items[prodIndex] = newFoodItem;

    notifyListeners();
  }
}

class Food {
  String id;
  String name;
  double price;
  String description;
  String quantityType;
  String imageDirectory;
  XFile image;

  Food({
    this.id,
    @required this.name,
    @required this.price,
    this.description,
    @required this.quantityType,
    this.imageDirectory,
    this.image,
  });
}
