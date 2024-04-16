import 'package:audio_player/Pages/home.dart';
import 'package:audio_player/Pages/search.dart';
import 'package:audio_player/Pages/yourlibrary.dart';
import 'package:audio_player/models/Music.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget miniPlayer(Music? music, {bool stop = false}) {
    if (music == null) {
      return SizedBox();
    }

    return AnimatedContainer(
        duration: const Duration(microseconds: 500),
        color: Colors.blueGrey,
        height: 50,
        child: Row(children: [
          Image.network(
            music.image,
            fit: BoxFit.cover,
          ),
          Text(
            music.name,
            style: const TextStyle(color: Colors.white),
          )
        ]));
  }

  final Tabs = [Home(), search(), yourlibrary()];
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs[currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (currentIndex) {
            print("The Current Index is $currentIndex");
            currentTabIndex = currentIndex;
            setState(() {}); //rendering re
          },
          backgroundColor: Colors.black45,
          selectedLabelStyle: TextStyle(color: Colors.white),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books,
                  color: Colors.white,
                ),
                label: "Library")
          ]),
    );
  }
}
