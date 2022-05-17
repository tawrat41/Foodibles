import 'package:flutter/material.dart';
import 'package:foodibles_manage/Theme/FoodItem.dart';
import 'package:provider/provider.dart';

class EditFoodItemPage extends StatefulWidget {
  final Food food;
  final String categoryOfFood;

  const EditFoodItemPage({Key key, this.food, this.categoryOfFood})
      : super(key: key);
  @override
  _EditFoodItemPageState createState() => _EditFoodItemPageState();
}

class _EditFoodItemPageState extends State<EditFoodItemPage> {
  // final _priceFocusNode = FocusNode(); //for text field cursor moving
  // final _descFocusNode = FocusNode();
  // final _imageFocusNode = FocusNode();
  // final _imageDirectoryController = TextEditingController();
  //we want to preview the image
  //!!!!!!!!!!!! WARNING !!!!!!!!!!!!
  //focus nodes are active even if we leave this widget, so we must clear the memory of them
  //so we need to dispose them
  final _form = GlobalKey<FormState>();
  String category = '';
  var _editedFood = Food(
      price: 0,
      description: '',
      imageDirectory: '',
      name: '',
      quantityType: '');

  var _initValues = {
    'name': '',
    'price': '',
    'description': '',
    'imageUrl': '',
    'quantityType': '',
  };

  var _isInit = true;
  var _isLoading = false; //for loading indicator

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // if (_isInit) {
    //taking the passed Food's id from user_Food_item screen
    // if (FoodId != null) {
    //if we are editing, only then we will be doing this
    _editedFood = Provider.of<FoodItem>(context, listen: false)
        .findByName(widget.categoryOfFood, widget.food.name);
    _initValues = {
      'name': _editedFood.name,
      'price': _editedFood.price.toString(),
      'description': _editedFood.description,
      'imageUrl': _editedFood.imageDirectory,
      'quantityType': _editedFood.quantityType,
    };
    // _imageDirectoryController.text = _editedFood.imageDirectory;
    //because in this case we are using a controller, with that we cant use the initial value
    // }
    // }
    // _isInit = false;
    super.didChangeDependencies();
  }

  // @override
  // void _updateimageDirectory() {
  //   if (!_imageFocusNode.hasFocus) {
  //     setState(() {});
  //   }
  // }

  // void dispose() {
  //   _imageFocusNode.removeListener(_updateimageDirectory); //same as following
  //   _priceFocusNode.dispose();
  //   _descFocusNode.dispose(); //clear ups memory of focus nodes
  //   _imageDirectoryController.dispose(); //also controllers need to be disposed
  //   _imageFocusNode.dispose();

  //   super.dispose();
  // }

  Future<void> _saveForm() async {
    final isValid =
        _form.currentState.validate(); //checking if the inputs are valid
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true; //for loading indicator
    });
    await Provider.of<FoodItem>(context, listen: false).updateFoodItem(
        context, widget.categoryOfFood, _editedFood, _editedFood);

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop(); //go to prev page

    // Navigator.of(context).pop(); //go to prev page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Food'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), //loading indicator
            )
          : Padding(
              //the page
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form, //important, read global key
                child: ListView(
                  //use single child view with child column when the page is long
                  //because of more widgets and inputs. Because listview reloads the widgets when they
                  //reappear on the screen, which might cause data loss in input.
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'name'),
                      textInputAction: TextInputAction
                          .next, //what will keyboard's enter button show
                      onFieldSubmitted: (_) {
                        // FocusScope.of(context).requestFocus(_priceFocusNode);
                        //going to the next text field
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a name'; //checking on the input
                        }
                        return null; //this is must,if everything fine, this works
                      },
                      onSaved: (value) {
                        _editedFood = Food(
                          name: value,
                          price: _editedFood.price,
                          description: _editedFood.description,
                          imageDirectory: _editedFood.imageDirectory,
                          quantityType: _editedFood.quantityType,

                          // isFavorite: _editedFood.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // focusNode:
                      //     _priceFocusNode, //prev to this text field transation
                      // onFieldSubmitted: (_) {
                      //   FocusScope.of(context).requestFocus(_descFocusNode);
                      // },
                      onSaved: (value) {
                        _editedFood = Food(
                          name: _editedFood.name,
                          price: double.parse(value),
                          description: _editedFood.description,
                          imageDirectory: _editedFood.imageDirectory,
                          quantityType: _editedFood.quantityType,

                          // isFavorite: _editedFood.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a valid number greater than zero';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],

                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      // focusNode: _descFocusNode,
                      //as we have multiline, so we cant go to next textfield using button
                      onSaved: (value) {
                        _editedFood = Food(
                          name: _editedFood.name,
                          price: _editedFood.price,
                          description: value,
                          imageDirectory: _editedFood.imageDirectory,
                          quantityType: _editedFood.quantityType,

                          // isFavorite: _editedFood.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Description'; //checking on the input
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['imageUrl'],

                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.emailAddress,
                      // focusNode: _descFocusNode,
                      //as we have multiline, so we cant go to next textfield using button
                      onSaved: (value) {
                        _editedFood = Food(
                          name: _editedFood.name,
                          price: _editedFood.price,
                          description: _editedFood.description,
                          imageDirectory: value,
                          quantityType: _editedFood.quantityType,

                          // isFavorite: _editedFood.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide an Image Url'; //checking on the input
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text('Submit'),
                        color: Colors.orangeAccent,
                        textColor: Colors.white,
                        onPressed: _saveForm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
