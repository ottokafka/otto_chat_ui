import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';


class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Localhost for android - 10.0.2.2
  // Localhost for iOS - 127.0.0.1
  Map<String, String> headers = {
    "Autherization": "somehting",
  };

  final IOWebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://localhost:4000/socket',
    headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im90dG8ga2Fma2VhYSIsImlzcyI6Im1hY2NoYXQuY29tIn0.0gXbLGD09PmUQFyMXDwEFVMBwqCGFgpmxu5LS1NUwFs"
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('No connection');
            case ConnectionState.waiting:
              return Column(
                children: [
                  Text(
                    'Connected',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  TextButton(
                      onPressed: () {
                        channel.sink.add("hello dude");
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ))
                ],
              );
            case ConnectionState.active:
              return Column(
                children: [
                  Text(
                    '${snapshot.data}',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  TextButton(
                    onPressed: () {
                      channel.sink.add("hello again");
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )
                ],
              );
            case ConnectionState.done:
              return Text('${snapshot.data} (closed)');
          }
        },
      ),
    );
  }
}

void sendMessage() async {
  final messageBody = "Hello dude";

  // final Message message = new Message(
  //   message: messageBody,
  //   userID: "otto",
  //   date: DateTime.now().toString(),
  // );
  final jsonMessage = messageBody;
  // channel.sink.add(jsonMessage);
  // messageTextController.clear();
}
