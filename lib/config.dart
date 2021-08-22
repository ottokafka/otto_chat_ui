import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var websocketURL = dotenv.env['WEBSOCKET_URL'];
var url = dotenv.env['URL'];
var port = dotenv.env['PORT'];

class Config {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1

  // DEV Websocket server IP and port for chat feature
  // static String websocketIP = 'ws://localhost:4000/socket';

  // Prod raspberry pi server
  static String websocketIP = "ws://$websocketURL";

  // static int websocketPort = 4000;

  // // DEV Main server URL and Port
  // static String url = "localhost" + ":";
  // static String port = "4000";

  // Prod Main server URL and Port

  // Add a contact
  static Uri addContactURL = Uri.parse("http://$url:$port/addcontact");

  static Uri loginURL = Uri.parse("http://$url:$port/signin");
  static Uri signupURL = Uri.parse("http://$url:$port/create");
}

// initailize database for app
// contacts
void initailizeApp() async {
  await dotenv.load(fileName: ".env");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var list = prefs.getStringList("contacts");
  print(list);
  if (list != null) {
    print("list is not null");
  } else {
    await prefs.setStringList("contacts", ['otto']);
  }
  // await prefs.setString("token", token);
}
