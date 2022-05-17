import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryOfFoods with ChangeNotifier {
  final firebaseRef = FirebaseDatabase.instance.reference();

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final firebaseUser = Provider.of<User>(context);
  // }

  List<CategoryClass> _categories = [];

  List<CategoryClass> get categories {
    return [..._categories];
  }

  CategoryClass findById(String id) {
    return _categories.firstWhere((cat) => cat.id == id);
  }
  // Future<void> addCategory(CategoryClass category,User user) async {

  Future<void> addCategory(CategoryClass category) async {
    final newCategory = CategoryClass(
      // id: category.id,
      name: category.name,
    );

    _categories.add(newCategory);
    notifyListeners();
  }

  bool categoryExists(String name) {
    if (_categories.firstWhere((cat) => cat.name == name, orElse: () => null) ==
        null) {
      return false;
    } else {
      return true;
    }
  }
}

class CategoryClass {
  String id;
  String name;

  CategoryClass({
    this.id,
    @required this.name,
  });
}
