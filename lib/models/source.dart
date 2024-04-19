class source {
  late int sourceID;
  String author;
  String year;
  String type;

  source({
    required this.author,
    required this.year,
    required this.type,
  });

  source.withId({
    required this.sourceID,
    required this.author,
    required this.year,
    required this.type,
  });

  // Getter methods for author, year, and type
  String get sourceAuthor => author;
  String get sourceYear => year;
  String get sourceType => type;

  // Setter methods for author, year, and type with length validation
  set sourceAuthor(String author) {
    if (author.length <= 250) {
      this.author = author;
    } else {
      throw ArgumentError('Author name cannot exceed 250 characters');
    }
  }

  set sourceYear(String year) {
    if (year.length <= 4) {
      this.year = year;
    } else {
      throw ArgumentError('Year should be a 4-digit number');
    }
  }

  set sourceType(String type) {
    if (type.length <= 100) {
      this.type = type;
    } else {
      throw ArgumentError('Source type cannot exceed 100 characters');
    }
  }

  // Convert Source object to a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (sourceID != null) {
      map['sourceID'] = sourceID;
    }
    map['author'] = author;
    map['year'] = year;
    map['type'] = type;
    return map;
  }

  // Convert a Map object to Source object
  static source fromMap(Map<String, dynamic> map) {
    return source.withId(
      sourceID: map['sourceID'],
      author: map['author'],
      year: map['year'],
      type: map['type'],
    );
  }
}
