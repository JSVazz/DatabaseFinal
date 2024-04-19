class AudioModel {
  late int audioId;
  late String audioURL;

  AudioModel({
    required this.audioId,
    required this.audioURL,
  });

  // Convert AudioModel object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'audioId': audioId,
      'audioURL': audioURL,
    };
  }

  // Convert a Map object to AudioModel object
  static AudioModel fromMap(Map<String, dynamic> map) {
    return AudioModel(
      audioId: map['audioId'],
      audioURL: map['audioURL'],
    );
  }
}
