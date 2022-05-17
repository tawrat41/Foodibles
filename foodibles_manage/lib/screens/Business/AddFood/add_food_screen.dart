import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../Theme/FoodItem.dart';
import '../../../constants.dart';

class AddFoodScreen extends StatefulWidget {
  static const routeName = '/add-food';
  String categoryName;
  AddFoodScreen(this.categoryName);

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _form = GlobalKey<FormState>();
  bool isOptionPressed = false;
  // Food newFood = new Food();
  Map<String, String> _newFood = {
    'name': '',
    'price': '',
    'quantityType': '',
    'description': '',
    'imageUrl': '',
  };
  XFile _image;
  bool imageSubmitted = false;

  final _imageFocusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();

  _imgFromGallery() async {
    try {
      XFile image = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = image;
        imageSubmitted = true;
      });
      // newFood.image = _image;
    } catch (e) {
      print(e);
    }
  }

  void dispose() {
    _imageFocusNode.dispose(); //also controllers need to be disposed
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //this is needed to update the changes in data, in this case, form data
    Map<String, String> _newFood = {
      'name': '',
      'price': '',
      'quantityType': '',
      'description': '',

      // 'id': '',
    };
    super.didChangeDependencies();
  }

  void _saveForm(firebaseUser) {
    final isValid =
        _form.currentState.validate(); //checking if the inputs are valid
    if (!isValid) {
      print("invalid form");
      return;
    }
    _form.currentState.save();
    print(_newFood);
    Food newFood = new Food(
      name: _newFood['name'],
      description: _newFood['description'],
      price: double.parse(_newFood['price']),
      quantityType: _newFood['quantityType'],
      imageDirectory: _newFood['imageUrl'],
      // image: _image,
    );
    Provider.of<FoodItem>(context, listen: false)
        .addFood(widget.categoryName.toString(), newFood, firebaseUser);
    // print(widget.categoryName);
    // print(Provider.of<FoodItem>(context, listen: false)
    //     .getFoods(widget.categoryName.toString()));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final firebaseUser = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("New Food"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newFood['name'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid Price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a valid Price greater than zero';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _newFood['price'] = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity type'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a quantity type, ie. /pc';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  _saveForm(firebaseUser);
                },
                onSaved: (value) {
                  _newFood['quantityType'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide an Image url';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newFood['imageUrl'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _newFood['description'] = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a Description'; //checking on the input
                  }
                  return null;
                },
              ),
              isOptionPressed
                  ? Column(
                      children: <Widget>[
                        Text("data"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("2"),
                            Text("1"),
                          ],
                        )
                      ],
                    )
                  : Align(),
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOptionPressed = true;
                    });
                    // isOptionPressed = false;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Add Option"),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  color: kPrimarylightColor,
                  child: Text("Add Food"),
                  onPressed: () {
                    print("map of newfood $_newFood");
                    _saveForm(firebaseUser);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
