import 'package:flutter/cupertino.dart';

class MyUser {
  final String userId;
  MyUser({this.userId});
}

class UserProvider with ChangeNotifier {
  String userId = '';
}
