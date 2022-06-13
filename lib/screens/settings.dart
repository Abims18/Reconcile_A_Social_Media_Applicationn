import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/utils/firebase.dart';

import '../models/user.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_backspace, color: Theme.of(context).primaryColor),
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontSize: 30, color: Theme.of(context).primaryColor),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: usersRef.doc(_auth.currentUser.uid).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  UserModel user = UserModel.fromJson(snapshot.data.data());
                  return ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Dark Mode",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        subtitle: Text("Use the dark mode"),
                        trailing: Consumer<ThemeNotifier>(
                          builder: (context, notifier, child) =>
                              CupertinoSwitch(
                                onChanged: (val) {
                                  notifier.toggleTheme();
                                },
                                value: notifier.dark,
                                activeColor: Theme.of(context).accentColor,
                              ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                          title: Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: Text(user.email),
                          trailing: Icon(Icons.email)),
                      Divider(),
                      ListTile(
                          title: Text(
                            "College Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: (user.college != null)?Text(user.college):Text("Add college via edit profile"),
                          trailing: Icon(Icons.build)),
                      Divider(),
                      ListTile(
                          title: Text(
                            "About",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: Text(
                              "Made with love"),
                          trailing: Icon(Feather.heart, color: Colors.red,)),

                    ],
                  );
                }
              })),
    );
  }
}
