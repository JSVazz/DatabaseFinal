// ignore_for_file: file_names

import 'package:audio_player/models/Music.dart';

class MusicOperations {
  MusicOperations._() {}
  static List<Music> getMusic() {
    return <Music>[
      Music(
          'Toofan', //name
          'https://c.ndtvimg.com/2021-03/6kl5pk58_farhans-toofan_625x300_10_March_21.jpg', // imageurl
          'Dekh Toofan Aaya hai', // desc
          'assests/Shayad (From_Love Aaj Kal_).mp3'), // audiourl
      Music(
          'Gully Boy',
          'https://c-cl.cdn.smule.com/rs-s95/arr/44/ec/a14c9db3-f454-4a86-80f0-ac9d42f6e87c_256.jpg',
          'Apna Time Aayega',
          'assests/Shayad (From_Love Aaj Kal_).mp3'),
      Music(
          'Ae Dil Hai Mushkil ',
          'https://c-cl.cdn.smule.com/rs-s-sf-4/arr/5e/ac/80498fa2-60ab-4c61-bf43-61b3df15f546.jpg',
          'Ae Dil Hai Mushkil ',
          'assests/Shayad (From_Love Aaj Kal_).mp3'),
      Music(
          'Bajirao Mastani',
          'https://c-cl.cdn.smule.com/rs-s92/arr/35/61/65d550a8-6d4e-4837-a067-c65b9e548ad7.jpg',
          'Malhari',
          'assets/Bhool Bhulaiyaa 2 Title Track (From _Bhool Bhulaiyaa 2_).mp3'),
    ];
  }
}
