class quote {
  late int quoteId;
  late int srcID;
  late int authID;
  String text;

  quote({
    required this.srcID,
    required this.text,
    required this.authID,
  });

  quote.withId({
    required this.quoteId,
    required this.srcID,
    required this.text,
    required this.authID,
  });

  // Getter methods for sourceID, text, and authorID
  int get quoteSourceID => srcID;
  String get quoteText => text;
  int get quoteAuthorID => authID;

  // Setter methods for sourceID, text, and authorID
  set quoteSourceID(int srcID) {
    this.srcID = srcID;
  }

  set quoteText(String text) {
    this.text = text;
  }

  set quoteAuthorID(int authID) {
    this.authID = authID;
  }

  // Convert Quote object to a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (quoteId != null) {
      map['quoteID'] = quoteId;
    }
    map['srcID'] = srcID;
    map['text'] = text;
    map['authID'] = authID;
    return map;
  }

  // Convert a Map object to Quote object
  static quote fromMap(Map<String, dynamic> map) {
    return quote.withId(
      quoteId: map['quoteID'],
      srcID: map['srcID'],
      text: map['text'],
      authID: map['authID'],
    );
  }
}
