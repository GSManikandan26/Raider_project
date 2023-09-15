// import 'package:botbridge_green/Model/Response/SignUpSData.dart';
// import 'package:flutter/foundation.dart';

// class UserProvider extends ChangeNotifier {
//   SignupUser _user = SignupUser(
//     userName: '',
//     name: '',
//     email: '',
//     gender: '',
//     password: '',
//     userimage: '',
//     age: '',
//     location: '',
//     mobile: '',
//   );

//   SignupUser get user => _user;

//   void setUser(String user) {
//     _user = SignupUser.fromJson(user);
//     notifyListeners();
//   }

//   void setUserFromModel(SignupUser user) {
//     _user = user;
//     notifyListeners();
//   }
// }


import 'package:botbridge_green/Model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    token: '',
    password: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}