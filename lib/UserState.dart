import 'package:flutter/foundation.dart';

class UserState with ChangeNotifier {
  UserState();

  String _businessID = "";
  void setBusinessID(String text) {
    _businessID = text;
    notifyListeners();
  }

  String get getBusinessID => _businessID;
}
