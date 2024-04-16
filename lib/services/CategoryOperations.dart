// ignore_for_file: file_names
import 'package:audio_player/models/category.dart';

class CategoryOperations {
  static List<category> getCategories() {
    return <category>[
      category("Top Songs",
          "https://i1.sndcdn.com/artworks-000079030140-y15xfq-t500x500.jpg"),
      category("Arijit Singh Songs",
          "https://i.scdn.co/image/ab67616d0000b273459c4f1a89716e40ed5ff12b"),
      category("MJ Songs",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9_IgFwdCuJS0qtV7JdaP-b7eKuiZ2Jdkz_CBjBQE7Ew&s"),
      category("Old Songs",
          "https://i.scdn.co/image/ab67616d0000b27380cb885032c34768ee32a543"),
      category("Top Songs",
          "https://i1.sndcdn.com/artworks-000079030140-y15xfq-t500x500.jpg"),
      category("Old Songs",
          "https://i.scdn.co/image/ab67616d0000b27380cb885032c34768ee32a543"),
    ];
  }
}
