class ImageModel {
  late int imageID;
  late String imageURL;

  ImageModel({
    required this.imageID,
    required this.imageURL,
  });

  // Convert ImageModel object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'imageID': imageID,
      'imageURL': imageURL,
    };
  }

  // Convert a Map object to ImageModel object
  static ImageModel fromMap(Map<String, dynamic> map) {
    return ImageModel(
      imageID: map['imageID'],
      imageURL: map['imageURL'],
    );
  }
}
