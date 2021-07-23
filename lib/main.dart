import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

final DateTime now = DateTime.now();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Otto chat';
    return MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

// Temp token delete
var token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Im90dG8iLCJpc3MiOiJtYWNjaGF0LmNvbSJ9.iFE0KK3QByXFDzgjysJ6GNSUNUZnftE24F_IV4kYgH8";

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  final WebSocketChannel _channel = IOWebSocketChannel.connect(
    'ws://localhost:4000/socket',
    headers: {"Authorization": token},
  );

  var user = "otto";

  List messages = [];

  @override
  void initState() {
    super.initState();

    _channel.stream.listen((data) => setState(() => messages.add(data)));
    print("2");
  }

  @override
  Widget build(BuildContext context) {
    print("2");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24),
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var msg = Msg.fromJson(jsonDecode(messages[index]));
                    print(messages[index]);
                    return Container(
                      margin: EdgeInsets.all(4),
                      child: Align(
                        alignment: msg.user == user
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: Chip(
                          backgroundColor: msg.user == user
                              ? Colors.lightBlue[100]
                              : Colors.lightGreenAccent[100],
                          padding: EdgeInsets.all(4),
                          label: Text(msg.message),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 24),
            IconButton(
                onPressed: () {
                  dispose();
                },
                icon: Icon(Icons.exit_to_app_outlined)),
            SizedBox(height: 24),
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      var msg =
          '{"user": "otto", "user2":"shen", "message": "${_controller.text}", "date":"$now"}';

      _channel.sink.add(msg);
    }
  }

  // static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  // final String formatted = formatter.format(now);

  void selectUser() {
    var selectedUser =
        '{"user": "otto", "user2":"shen", "message": "helloy", "date": "date"}';

    // Msg.fromJson(jsonDecode(selectedUser));

    // Map<String, dynamic> user = jsonDecode(selectedUser);

    _channel.sink.add(selectedUser);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

class Msg {
  final String date;
  final String user;
  final String user2;
  final String message;

  Msg({
    required this.date,
    required this.user,
    required this.user2,
    required this.message,
  });

  factory Msg.fromJson(Map<String, dynamic> json) {
    return Msg(
      date: json['date'],
      user: json['user'],
      user2: json['user2'],
      message: json['message'],
    );
  }
}
