import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_player/Pages/home.dart';
import 'package:audio_player/Pages/search.dart';
import 'package:audio_player/Pages/yourlibrary.dart';
import 'package:audio_player/models/quote.dart';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late List<Widget> _tabs;
  quote? _quote;
  int _currentTabIndex = 0;
  late bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _tabs = [Home(_togglePlayback), const search(), const yourlibrary()];
  }

  Widget _miniPlayer() {
    return GestureDetector(
      onTap: () {
        // Handle tap on mini player
      },
      child: Container(
        color: Colors.blueGrey,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_quote != null && _quote!.imageURL != null)
              Image.network(
                _quote!.imageURL!,
                fit: BoxFit.cover,
              ),
            if (_quote != null)
              Text(
                _quote!.quoteText ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            IconButton(
              onPressed: _togglePlayback,
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _miniPlayer(),
          BottomNavigationBar(
            currentIndex: _currentTabIndex,
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            selectedLabelStyle: const TextStyle(color: Colors.white),
            backgroundColor: Colors.black45,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Colors.white),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books, color: Colors.white),
                label: 'Library',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _togglePlayback() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_quote != null) {
        if (_isPlaying) {
          _playAudio(_quote!.audioURL);
        } else {
          _pauseAudio();
        }
      } else {
        // Handle the case where _quote is null
        print('Error: _quote is null.');
      }
    });
  }

  void _playAudio(String audioUrl) async {
    try {
      await _audioPlayer.play(audioUrl as Source);
    } catch (e) {
      // Handle error
      print('Error playing audio: $e');
    }
  }

  void _pauseAudio() {
    _audioPlayer.pause();
  }
}
