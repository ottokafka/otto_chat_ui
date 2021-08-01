import 'package:http/http.dart' as http;
import 'package:mac_chat/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../globals.dart';

class User {
  final String message;
  final String user;

  User({required this.message, required this.user});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      message: json['message'],
      user: json['user'],
    );
  }
}

// Login User
Future<User> addContact(String name) async {
  print(name);

  try {
    var url = Config.addContactURL;
    String json = '{"user": "$name"}';

    // will grab the token from the device
    // NOTE: String? means it could return null or string NULL SAFTY system
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

// if token is null send to sign in page
    // if (token == null) {
    //   print("add_contact: No token saved on device, re-sign in");

    //   // return User.fromJson(jsonDecode({`"user":"otto"`}));
    // }

    Map<String, String>? headers = {
      "Content-type": "application/json",
      "Authorization": token.toString()
    };

    print(json);
    var response = await http.post(url, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);

// save added contact to local device
// get the list and check if otto is already added
    String username = parsedJson["user"];
    String message = parsedJson["message"];

// If the username is "" means no token invalid or no user
    if (username == "") {
      return User.fromJson(jsonDecode(response.body));

      // Username is in the database lets add it to local device
    } else {
      List<String>? contactsList = prefs.getStringList("contacts");

      contactsList!.add(username);

      // ["otto", "bob"]
      print(contactsList);
      await prefs.setStringList("contacts", contactsList);
      reload = true;
      return User.fromJson(jsonDecode(response.body));
    }
  } catch (err) {
    throw err;
    // print(err);
  }
}
