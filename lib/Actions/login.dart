import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Login User
loginUser(email, password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(email);
  print(password);
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1
  try {
    var url = ConfigURL.postApiLoginUser;
    String json = '{"email": "$email", "password": "$password"}';
    print(json);
    Map<String, String> headers = {"Content-type": "application/json"};
    var response = await http.post(url, headers: headers, body: json);

    print('Response body: ${response.body}');

    // we parse the json and use the jsonDecode method
    var parsedJson = jsonDecode(response.body);
    // print how just the token numbers
//  print(parsedJson["token"]);
    var tokenUser = parsedJson["tokenUser"];
    if (parsedJson["msg"] == "Invalid Credentials") {
      await prefs.setString("msg", parsedJson["msg"]);
    }

    // This saves the token into the device as token: j9384ujhsdf
    await prefs.setString("tokenUser", tokenUser);

    // will grab the token from the device
    String getTokenUser = (prefs.getString("tokenUser"));

    // show that the token is coming from device storage

    print(getTokenUser);
  } catch (err) {
    print(err);
  }
}
