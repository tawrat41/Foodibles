import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:new_foodibles/screens/Customer/Homepage/cust_homepage.dart';
import 'package:provider/provider.dart';

class CustomerDetailsScreen extends StatefulWidget {
  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final firebaseRef = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    //this is needed to update the changes in data, in this case, form data
    Map<String, String> _customerData = {
      'name': '',
      'email': '',
      'address': '',
      'gender': '',
      'age': '',
      'contactNo': '',
      'id': '',
    };
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Map<String, String> _customerData = {
    'name': '',
    'email': '',
    'address': '',
    'gender': '',
    'age': '',
    'contactNo': '',
    'id': '',
  };

  void _addCustomer(Map<String, String> custData) {
    final id = custData['id'];
    // final name = custData['name'];
    firebaseRef.child("foodies/$id").set({
      'id': custData['id'],
      'name': custData['name'],
      'email': custData['email'],
      'address': custData['address'],
      'gender': custData['gender'],
      'age': custData['age'],
      'contactNo': custData['contactNo'],
    });
    //push() for creating an id, under which set() the values
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //get the user data

    return Scaffold(
      // backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text('Sign Up Completion'),
      ),
      body: Card(
        // color: Color(0xffE5E5E5),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Color.fromRGBO(238, 238, 238, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Your Name',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid name!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _customerData['name'] = value;
                        });
                        // _authData['email'] = value;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address',
                        border: InputBorder.none,
                      ),
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
                          _customerData['address'] = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Contact No',
                        border: InputBorder.none,
                      ),
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
                          _customerData['contactNo'] = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // maxLines: 3,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid description!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _customerData['age'] = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      color: Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: InputBorder.none,
                      ),
                      textInputAction: TextInputAction.next,
                      // keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Invalid gender!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _customerData['gender'] = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _formKey.currentState.save();
                        _customerData['id'] = user.uid;
                        _customerData['email'] = user.email;

                        print(_customerData);
                        _addCustomer(_customerData);
                        Navigator.pushReplacementNamed(
                            context, CustHomePage.routeName);
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                    // color: Colors.amber,
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
