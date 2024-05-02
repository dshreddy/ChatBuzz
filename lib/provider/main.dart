import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String username = "";
  String password = "";

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
