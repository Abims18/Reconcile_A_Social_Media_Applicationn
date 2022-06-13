import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:social_media_app/utils/constants.dart';

AppBar header(context) {
  return AppBar(
    backgroundColor: Constants.darkAccent,
    title: Text('Reconcile'),
    centerTitle: true,
    actions: [Padding(
      padding: const EdgeInsets.only(right:20.0),
      child: Icon(Feather.bell),
    )],
  );
}
