import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodibles_manage/screens/Business/Homepage/busi_homepage_screen.dart';
import 'package:provider/provider.dart';
// import 'fire';

class BusinessDetailsScreen extends StatefulWidget {
  static const routeName = '/business-detail-screen';

  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  final firebaseRef = FirebaseDatabase.instance.reference();
  //with this we can read,write,update firebase database
  final _formKey = GlobalKey<FormState>();
  String mail;
  Map<String, String> _restaurantData = {
    'name': '',
    'email': '',
    'address': '',
    'description': '',
    'contactNo': '',
    'id': '',
  };

  void _addRestaurant(Map<String, String> restData) {
    final id = restData['id'];
    final name = restData['name'];
    firebaseRef.child("restaurants/$id").set({
      'name': restData['name'],
      'email': restData['email'],
      'address': restData['address'],
      'description': restData['description'],
      'contactNo': restData['contactNo'],
      'id': restData['id'],
    });
    //push() for creating an id, under which set() the values
  }

  @override
  void didChangeDependencies() {
    //this is needed to update the changes in data, in this case, form data
    Map<String, String> _restaurantData = {
      'name': '',
      'email': '',
      'address': '',
      'description': '',
      'contactNo': '',
      'id': '',
    };
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //get the user data
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Completion'),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(4),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Restaurant Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Invalid name!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _restaurantData['name'] = value;
                      mail = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Invalid address!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _restaurantData['address'] = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contact No'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value.isEmpty || value.length != 11) {
                      return 'Invalid number!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _restaurantData['contactNo'] = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Invalid description!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _restaurantData['description'] = value;
                    });
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  child: RaisedButton(
                    child: Text('Submit'),
                    color: Colors.amber,
                    onPressed: () async {
                      setState(() {
                        _formKey.currentState.save();
                        _restaurantData['id'] = user.uid;
                        _restaurantData['email'] = user.email;

                        // print(_restaurantData);
                        _addRestaurant(_restaurantData);
                        Navigator.pushReplacementNamed(
                            context, BusiHomeScreen.routeName);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
