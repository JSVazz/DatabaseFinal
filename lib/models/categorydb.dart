class Category {
  late int categoryID;
  String categoryName;
  String description;
  String imageURL;

  Category(
    int i, {
    required this.categoryName,
    required this.description,
    required this.imageURL,
  });

  Category.withId({
    required this.categoryID,
    required this.categoryName,
    required this.description,
    required this.imageURL,
  });

  // New constructor without ID
  Category.withoutID({
    required this.categoryName,
    required this.description,
    required this.imageURL,
  });

  // Getter methods for categoryName and description
  String get categoryCategoryName => categoryName;
  String get categoryDescription => description;

  // Setter methods for categoryName and description
  set categoryCategoryName(String categoryName) {
    this.categoryName = categoryName;
  }

  set categoryDescription(String description) {
    this.description = description;
  }

  // Convert Category object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'categoryID': categoryID,
      'categoryName': categoryName,
      'description': description,
      'imageURL': imageURL, // Store imageURL as a string
    };
  }

  // Convert a Map object to Category object
  static Category fromMap(Map<String, dynamic> map) {
    return Category.withId(
      categoryID: map['categoryID'],
      categoryName: map['categoryName'],
      description: map['description'],
      imageURL: map['imageURL'], // Fetch imageURL as a string
    );
  }
}
