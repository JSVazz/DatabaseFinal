// ignore_for_file: file_names
import 'package:audio_player/models/categorydb.dart';
import 'package:audio_player/utils/databasehelper.dart';

class CategoryOperations {
  static Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    List<Category> dbCategories = await DatabaseHelper().getAllCategories();
    dbCategories.forEach((dbCategory) {
      Category newCategory = Category.withoutID(
        categoryName: dbCategory.categoryName,
        description: dbCategory.description,
        imageURL: dbCategory.imageURL,
      );
      categories.add(newCategory);
    });
    return categories;
  }
}
