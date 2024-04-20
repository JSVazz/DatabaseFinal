import 'package:audio_player/models/Music.dart';
import 'package:audio_player/models/categorydb.dart';
import 'package:audio_player/services/CategoryOperations.dart';
import 'package:audio_player/services/MusicOperations.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function _miniPlayer;
  const Home(this._miniPlayer, {super.key});

  Widget createCategory(Category category) {
    return Container(
      color: Colors.blueGrey.shade300,
      child: Row(
        children: [
          Image.network(
            category.imageURL,
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          ),
          const Padding(padding: EdgeInsets.only(left: 8.0)),
          Text(
            category.categoryName,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<List<Widget>> CreatelistOfCategories() async {
    List<Category> categoryList =
        await CategoryOperations.getCategories(); // await the result
    // convert data to widget using map function
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();

    return categories;
  }

  Widget createMusic(Music music) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 200,
            width: 200,
            child: InkWell(
              onTap: () {
                _miniPlayer(music, stop: true);
              },
              child: Image.network(
                music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            music.name,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            music.desc,
            style: const TextStyle(color: Colors.white),
          ),
        ]));
  }

  Widget createMusicList(String label) {
    List<Music> musicList = MusicOperations.getMusic();
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return createMusic(musicList[index]);
                  },
                  itemCount: musicList.length),
            )
          ],
        ));
  }

  Widget createGrid() {
    return FutureBuilder<List<Widget>>(
      future: CreatelistOfCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            padding: const EdgeInsets.all(10),
            height: 285,
            child: GridView.count(
              childAspectRatio: 5 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: snapshot.data!,
            ),
          );
        }
      },
    );
  }

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.settings))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blueGrey.shade300,
          Colors.black,
          Colors.black,
          Colors.black,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          children: [
            createAppBar("howdy"),
            const SizedBox(
              height: 5,
            ),
            createGrid(),
            createMusicList('Made For You'),
            createMusicList('popular Playlists')
          ],
        ),
      )),
    );
  }
}
