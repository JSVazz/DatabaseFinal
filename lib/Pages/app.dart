import 'package:audio_player/Pages/home.dart';
import 'package:audio_player/Pages/search.dart';
import 'package:audio_player/Pages/yourlibrary.dart';
import 'package:audio_player/models/Music.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String audiosset = "assests/";
  final AudioPlayer _audioPlayer = AudioPlayer();
  // ignore: non_constant_identifier_names
  var Tabs = [];
  Music? music;
  int currentTabIndex = 0;
  late bool isPlaying;

  Widget miniPlayer(Music? music, {bool stop = false}) {
    this.music = music;
    setState(() {});
    Size deviceSize = MediaQuery.of(context).size;
    if (music == null) {
      return const SizedBox();
    }
    if (stop) {
      isPlaying = false;
      _audioPlayer.stop();
    }

    return AnimatedContainer(
        duration: const Duration(microseconds: 500),
        color: Colors.blueGrey,
        height: 50,
        width: deviceSize.width,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Image.network(
            music.image,
            fit: BoxFit.cover,
          ),
          Text(
            music.name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          IconButton(
              // ignore: void_checks
              onPressed: () async* {
                isPlaying = !isPlaying;
                if (isPlaying) {
                  await _audioPlayer.play(UrlSource(music.AudioURL));
                } else {
                  await _audioPlayer.pause();
                }
              },
              icon: isPlaying
                  ? const Icon(Icons.pause, color: Colors.white)
                  : const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    )),
        ]));
  }

  @override
  void initState() {
    super.initState();
    Tabs = [Home(miniPlayer), const search(), yourlibrary()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs[currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(music),
          BottomNavigationBar(
              currentIndex: currentTabIndex,
              onTap: (currentIndex) {
                //print("The Current Index is $currentIndex");
                currentTabIndex = currentIndex;
                setState(() {}); //rendering re
              },
              selectedLabelStyle: const TextStyle(color: Colors.white),
              backgroundColor: Colors.black45,
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
              ])
        ],
      ),
    );
  }
}
