// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class search extends StatelessWidget {
  const search({super.key});

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.search))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueGrey.shade300,
        Colors.black,
        Colors.black,
        Colors.black,
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Column(
        children: [createAppBar('Search Section')],
      ),
    );
  }
}
