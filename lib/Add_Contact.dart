import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mac_chat/Actions/add_contact.dart';

class AddContact extends StatefulWidget {
  static const String id = "AddContact";

  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() {
    return _AddContactState();
  }
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _controller = TextEditingController();
  Future<User>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
    );
  }

  buildColumn() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Contact Name'),
        ),
        TextButton.icon(
            onPressed: () {
              setState(() {
                _futureAlbum = addContact(_controller.text);
              });
            },
            icon: Icon(Icons.add),
            label: Text("New Contact")),
      ],
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              buildColumn(),
              SizedBox(height: 40),
              Text(snapshot.data!.message),
              Text(snapshot.data!.user),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
