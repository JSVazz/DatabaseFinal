import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_player/models/author.dart';
import 'package:audio_player/models/source.dart';
import 'package:audio_player/models/quote.dart';
import 'package:audio_player/models/categorydb.dart';
import 'package:audio_player/models/image.dart';
import 'package:audio_player/models/user.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper._();

  DatabaseHelper._createInstance();

  // Author Table
  String authorTable = 'Author';
  String colAuthorId = 'authorID';
  String colName = 'name';
  String colOccupation = 'occupation';

  // Source Table
  String sourceTable = 'Source';
  String colSourceId = 'sourceID';
  String colSourceAuthor = 'author';
  String colSourceYear = 'year';
  String colSourceType = 'type';

  // Quote Table
  String quoteTable = 'Quote';
  String colQuoteId = 'quoteID';
  String colQuoteSourceId = 'sourceID';
  String colQuoteText = 'text';
  String colQuoteAuthorId = 'authorID';

  // Category Table
  String categoryTable = 'Category';
  String colCategoryId = 'categoryID';
  String colCategoryName = 'categoryName';
  String colCategoryDescription = 'description';

  // Image Table
  String imageTable = 'Image';
  String colImageId = 'imageID';
  String colImageURL = 'imageURL';

  // User Table
  String userTable = 'User';
  String colUserEmail = 'email';
  String colUserPassword = 'password';
  String colUserUsername = 'username';

  factory DatabaseHelper() {
    _databaseHelper ??=
        DatabaseHelper._(); // Initialize _databaseHelper if it's null
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();

    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'audioPlayer.db');

    // Open/create the database at a given path
    var audioplayerDatabase =
        await openDatabase(path, version: 1, onCreate: createDb);
    return audioplayerDatabase;
  }

  void createDb(Database db, int newVersion) async {
    // create Author table
    await db.execute('''CREATE TABLE $authorTable(
        $colAuthorId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $colName TEXT, 
        $colOccupation TEXT)
        ''');
    // create Source table
    await db.execute('''CREATE TABLE $sourceTable(
          $colSourceId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $colSourceAuthor TEXT, 
          $colSourceYear TEXT,
          $colSourceYear TEXT)
          ''');
    // create Quote table
    await db.execute('''
        CREATE TABLE $quoteTable (
          $colQuoteId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colQuoteSourceId INTEGER,
          $colQuoteText TEXT,
          $colQuoteAuthorId INTEGER,
          FOREIGN KEY ($colQuoteSourceId) REFERENCES $sourceTable($colSourceId),
          FOREIGN KEY ($colQuoteAuthorId) REFERENCES $authorTable($colAuthorId))
          ''');

    // Create Category table
    await db.execute('''
      CREATE TABLE $categoryTable (
        $colCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colCategoryName TEXT,
        $colCategoryDescription TEXT
      )
    ''');

    // Create Image table
    await db.execute('''
      CREATE TABLE $imageTable (
        $colImageId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colImageURL TEXT
      )
    ''');

    // Create User table
    await db.execute('''
      CREATE TABLE $userTable (
        $colUserEmail TEXT PRIMARY KEY,
        $colUserPassword TEXT,
        $colUserUsername TEXT
      )
    ''');
  }

  //CRUD operations for Author table
  // Method to insert a new author into the database
  Future<int> createAuthor(author author) async {
    final db = await database;
    return db.insert('Author', author.toMap());
  }

  // Method to retrieve all authors from the database
  Future<List<author>> getAllAuthors() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Author');
    return List.generate(maps.length, (i) {
      return author.fromMap(maps[i]);
    });
  }

  // Method to retrieve an author by their ID
  Future<author?> getAuthorById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Author', where: 'authorID = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return author.fromMap(maps.first);
  }

  // Method to update an existing author in the database
  Future<int> updateAuthor(author author) async {
    final db = await database;
    return db.update('Author', author.toMap(),
        where: 'authorID = ?', whereArgs: [author.authorId]);
  }

  // Method to delete an author from the database
  Future<int> deleteAuthor(int id) async {
    final db = await database;
    return db.delete('Author', where: 'authorID = ?', whereArgs: [id]);
  }

  //CRUD operations for Source table
  // Create a new source
  Future<void> insertSource(source source) async {
    final db = await database;
    await db.insert(
      'Source',
      source.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all sources
  Future<List<source>> getAllSources() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Source');
    return List.generate(maps.length, (i) {
      return source.fromMap(maps[i]);
    });
  }

  // Retrieve a specific source by its ID
  Future<source?> getSourceById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Source', where: 'sourceID = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return source.fromMap(maps.first);
  }

  // Update a source
  Future<void> updateSource(source source) async {
    final db = await database;
    await db.update(
      'Source',
      source.toMap(),
      where: 'sourceID = ?',
      whereArgs: [source.sourceID],
    );
  }

  // Delete a source
  Future<void> deleteSource(int id) async {
    final db = await database;
    await db.delete(
      'Source',
      where: 'sourceID = ?',
      whereArgs: [id],
    );
  }

  //CRUD operations for Quote table
  // Method to insert a new quote into the database
  Future<int> createQuote(quote quote) async {
    final db = await database;
    return db.insert('Quote', quote.toMap());
  }

  // Method to retrieve all quotes from the database
  Future<List<quote>> getAllQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Quote');
    return List.generate(maps.length, (i) {
      return quote.fromMap(maps[i]);
    });
  }

  // Method to retrieve a quote by its ID
  Future<quote?> getQuoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('Quote', where: 'quoteID = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return quote.fromMap(maps.first);
  }

  // Method to update an existing quote in the database
  Future<int> updateQuote(quote quote) async {
    final db = await database;
    return db.update('Quote', quote.toMap(),
        where: 'quoteID = ?', whereArgs: [quote.quoteId]);
  }

  // Method to delete a quote from the database
  Future<int> deleteQuote(int id) async {
    final db = await database;
    return db.delete('Quote', where: 'quoteID = ?', whereArgs: [id]);
  }

  //CRUD operations for Category table
  // Method to insert a new category into the database
  Future<int> createCategory(Category category) async {
    final db = await database;
    return db.insert(categoryTable, category.toMap());
  }

  // Method to retrieve all categories from the database
  Future<List<Category>> getAllCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(categoryTable);
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  // Method to retrieve a category by its ID
  Future<Category?> getCategoryById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query(categoryTable, where: '$colCategoryId = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Category.fromMap(maps.first);
  }

  // Method to update an existing category in the database
  Future<int> updateCategory(Category category) async {
    final db = await database;
    return db.update(categoryTable, category.toMap(),
        where: '$colCategoryId = ?', whereArgs: [category.categoryID]);
  }

  // Method to delete a category from the database
  Future<int> deleteCategory(int id) async {
    final db = await database;
    return db
        .delete(categoryTable, where: '$colCategoryId = ?', whereArgs: [id]);
  }

  //CRUD operations for Image table
  // Create a new image
  Future<void> insertImage(ImageModel image) async {
    final db = await database;
    await db.insert(
      imageTable,
      image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all images
  Future<List<ImageModel>> getAllImages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(imageTable);
    return List.generate(maps.length, (i) {
      return ImageModel.fromMap(maps[i]);
    });
  }

  // Retrieve a specific image by its ID
  Future<ImageModel?> getImageById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(imageTable, where: '$colImageId = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return ImageModel.fromMap(maps.first);
  }

  // Update an image
  Future<void> updateImage(ImageModel image) async {
    final db = await database;
    await db.update(
      imageTable,
      image.toMap(),
      where: '$colImageId = ?',
      whereArgs: [image.imageID],
    );
  }

  // Delete an image
  Future<void> deleteImage(int id) async {
    final db = await database;
    await db.delete(
      imageTable,
      where: '$colImageId = ?',
      whereArgs: [id],
    );
  }

  //CRUD operations for User table
  // Create a new user
  Future<void> insertUser(user user) async {
    final db = await database;
    await db.insert(
      userTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all users
  Future<List<user>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(userTable);
    return List.generate(maps.length, (i) {
      return user.fromMap(maps[i]);
    });
  }

  // Retrieve a specific user by their email
  Future<user?> getUserByEmail(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query(userTable, where: '$colUserEmail = ?', whereArgs: [email]);
    if (maps.isEmpty) return null;
    return user.fromMap(maps.first);
  }

  // Update a user
  Future<void> updateUser(user user) async {
    final db = await database;
    await db.update(
      userTable,
      user.toMap(),
      where: '$colUserEmail = ?',
      whereArgs: [user.email],
    );
  }

  // Delete a user
  Future<void> deleteUser(String email) async {
    final db = await database;
    await db.delete(
      userTable,
      where: '$colUserEmail = ?',
      whereArgs: [email],
    );
  }
}
