import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:mac_chat/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

final DateTime now = DateTime.now();

class Chat extends StatelessWidget {
  static const String id = "Chat";
  final String user;
  final String user2;

  const Chat({Key? key, required this.user, required this.user2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(user2),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: ChatSetup(
        user: user,
        user2: user2,
        channel: IOWebSocketChannel.connect(Config.websocketIP,
            headers: {"Authorization": token, "user": user, "user2": user2}),
      ),
    );
  }
}

class ChatSetup extends StatefulWidget {
  final WebSocketChannel channel;
  final String user;
  final String user2;

  ChatSetup({
    Key? key,
    required this.channel,
    required this.user,
    required this.user2,
  }) : super(key: key);

  @override
  _ChatSetupState createState() => _ChatSetupState();
}

class _ChatSetupState extends State<ChatSetup> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = new ScrollController();

  List messages = [];
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    // initialize focus on textField
    myFocusNode = FocusNode();

    // initialize websocket connection
    widget.channel.stream.listen((data) => setState(() => messages.add(data)));
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    var user2 = widget.user2;

    void _sendMessage() async {
      if (_controller.text.isNotEmpty) {
        var msg =
            '{"user": "$user", "user2":"$user2", "message": "${_controller.text}", "date":"$now"}';
        // Add the msg to send to websocket server
        widget.channel.sink.add(msg);

        // Clear the text field after send
        _controller.clear();
        // Scroll to the bottom of the page when we enter a chat message
        await Future.delayed(Duration(milliseconds: 100));
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.easeOut);

        // After send focus cursor back onto the text input
        myFocusNode.requestFocus();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 24),
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var msg = Msg.fromJson(jsonDecode(messages[index]));

                  // Logic for sending
                  print("user:$user == msg.user:${msg.user}");
                  print(user == msg.user); // true
                  print("user2:$user2 == msg.user2:${msg.user2}");
                  print(user2 == msg.user2); // true
                  print(messages[index]);

                  // Logic for recieving
                  print("user:$user == msg.user:${msg.user2}"); // otto:otto
                  print(user == msg.user2); // true
                  print("user2:$user2 == msg.user:${msg.user}"); // shen2:shen2
                  print(user2 == msg.user); // true

                  // Will scroll to the bottom on loading of the chatpage
                  Timer(
                      Duration(milliseconds: 500),
                      () => _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent));
// user:otto == msg.user:otto && user2:shen1 == msg.user:shen1 - on send
// user2:shen2 == msg.user:shen2 && otto === otto - on recieve msg.user2 == user

// msg.user2:shen2 == user2:shen2 on recieve
                  return msg.user == user && msg.user2 == user2 ||
                          user == msg.user2 && user2 == msg.user
                      ? Container(
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
                        )
                      : Container();
                },
              ),
            ),
          ),
          // SizedBox(height: 24),
          Form(
            child: Container(
              color: Colors.white,
              child: TextField(
                  // maxLines: 2,
                  focusNode: myFocusNode,
                  autofocus: true,
                  controller: _controller,
                  decoration: InputDecoration(
                      // labelText: ' Send a message',
                      contentPadding: EdgeInsets.all(8)),
                  // onSubmitted allows user to press enter to sumbit
                  onSubmitted: (value) {
                    _sendMessage();
                  }),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: _sendMessage,
    //   tooltip: 'Send message',
    //   child: Icon(Icons.send),
    // ), // This trailing comma makes auto-formatting nicer for build methods.
  }

  @override
  void dispose() {
    widget.channel.sink.close();
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
