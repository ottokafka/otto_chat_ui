import 'package:http/http.dart' as http;
import 'package:mac_chat/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Login User
signup(email, password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(email);
  print(password);
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  try {
    String json = '{"name": "$email", "pin": "$password"}';
    print(json);
    Map<String, String> headers = {"Content-type": "application/json"};
    var response =
        await http.post(Config.signupURL, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    // print how just the token numbers
    var token = parsedJson["token"];
    if (parsedJson["message"] == "Invalid Credentials") {
      await prefs.setString("message", parsedJson["message"]);
    } else {
      // This saves the token into the device as token: j9384ujhsdf
      await prefs.setString("token", token);

      // will grab the token from the device
      String? gettoken = prefs.getString("token");

      // show that the token is coming from device storage

      print(gettoken);
    }
  } catch (err) {
    print(err);
  }
}
