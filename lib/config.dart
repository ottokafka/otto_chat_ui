class Config {
  // in web use localhost but in android use 10.0.2.2
  // ios work with 127.0.0.1

  // Websocket server IP and port for chat feature
  static String websocketIP = 'ws://localhost:4000/socket';
  // static int websocketPort = 4000;

  // Main server URL and Port
  static String url = "localhost" + ":";
  static String port = "4000";

  // // -------- Business APIs --------------------
  // static String postApiAppointmentsBusiness =
  //     "http://$url$port/api/appointments/business";

}
