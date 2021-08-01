import 'package:shared_preferences/shared_preferences.dart';

var token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im90dG8iLCJpc3MiOiJtYWNjaGF0LmNvbSJ9.iFE0KK3QByXFDzgjysJ6GNSUNUZnftE24F_IV4kYgH8";

class Config {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1

  // Websocket server IP and port for chat feature
  static String websocketIP = 'ws://localhost:4000/socket';
  // static int websocketPort = 4000;

  // Main server URL and Port
  static String url = "localhost" + ":";
  static String port = "4000";

  // Add a contact
  static Uri addContactURL = Uri.parse("http://localhost:4000/addcontact");
}

// initailize database for app
// contacts
void initailizeApp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList("contacts", ['otto']);
  await prefs.setString("token", token);
}
