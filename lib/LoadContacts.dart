import 'package:flutter/material.dart';
import 'package:mac_chat/Chat.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class LoadContacts extends StatefulWidget {
  static const String id = "LoadContacts";

  const LoadContacts({Key? key}) : super(key: key);

  @override
  _LoadContactsState createState() => _LoadContactsState();
}

class _LoadContactsState extends State<LoadContacts> {
  @override
  void initState() {
    super.initState();
    setState(() => {
          // on app load set the state
          // getContacts()
        });
  }

  Widget build(BuildContext context) {
    final appState = Provider.of<UserState>(context);
    appState.setStateContacts();
    print('${appState.getContactsList} contact list load contacts');

    return Column(
      children: [
        Container(
          child: Expanded(
            child: FutureBuilder(
                future: appState.fetchContacts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    print('project snapshot data is: ${snapshot.data}');
                    return Text("No data mate");
                  }
                  return ListView.builder(
                    itemCount: appState.getContactsList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: TextButton.icon(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Chat(
                                            user: appState.user!,
                                            user2: appState
                                                .getContactsList![index],
                                            token: appState.token!),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.person),
                                  label:
                                      Text(appState.getContactsList![index])),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ],
    );
  }
}
