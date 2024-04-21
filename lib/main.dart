import 'package:audio_player/Pages/app.dart';
import 'package:flutter/material.dart';
import 'package:audio_player/utils/databasehelper.dart';

void main() {
  DatabaseHelper.insertDataIntoDatabase(); // Call the static method
  runApp(const MaterialApp(
    title: "Audio Player",
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}
