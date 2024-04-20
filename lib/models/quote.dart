class quote {
  late int quoteId;
  late int quoteSourceId; // Foreign key for the source
  late int quoteAuthorId; // Foreign key for the author
  String quoteText;
  String imageURL;
  String audioURL;

  quote({
    required this.quoteSourceId,
    required this.quoteText,
    required this.quoteAuthorId,
    required this.imageURL,
    required this.audioURL,
  });

  quote.withId({
    required this.quoteId,
    required this.quoteSourceId,
    required this.quoteText,
    required this.quoteAuthorId,
    required this.imageURL,
    required this.audioURL,
  });

  // Convert Quote object to a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (quoteId != null) {
      map['quoteId'] = quoteId;
    }
    map['quoteSourceId'] = quoteSourceId;
    map['quoteText'] = quoteText;
    map['quoteAuthorId'] = quoteAuthorId;
    map['imageURL'] = imageURL;
    map['audioURL'] = audioURL;
    return map;
  }

  // Convert a Map object to Quote object
  static quote fromMap(Map<String, dynamic> map) {
    return quote.withId(
      quoteId: map['quoteId'],
      quoteSourceId: map['quoteSourceId'],
      quoteText: map['quoteText'],
      quoteAuthorId: map['quoteAuthorId'],
      imageURL: map['imageURL'],
      audioURL: map['audioURL'],
    );
  }
}
