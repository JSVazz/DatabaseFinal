class author {
  late int authorId;
  String name;
  String occupation;

  author({
    required this.name,
    required this.occupation,
  });

  author.withId({
    required this.authorId,
    required this.name,
    required this.occupation,
  });

  // Getter methods for name and occupation
  String get authorName => name;
  String get authorOccupation => occupation;

  // Setter methods for name and occupation with length validation
  set authorName(String name) {
    if (name.length <= 250) {
      this.name = name;
    } else {
      throw ArgumentError('Name cannot exceed 250 characters');
    }
  }

  set authorOccupation(String occupation) {
    if (occupation.length <= 250) {
      this.occupation = occupation;
    } else {
      throw ArgumentError('Occupation cannot exceed 250 characters');
    }
  }

  // Convert Author object to a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (authorId != null) {
      map['authorId'] = authorId;
    }
    map['name'] = name;
    map['occupation'] = occupation;
    return map;
  }

  // Convert a Map object to Author object
  static author fromMap(Map<String, dynamic> map) {
    return author.withId(
      authorId: map['authorId'],
      name: map['name'],
      occupation: map['occupation'],
    );
  }
}
