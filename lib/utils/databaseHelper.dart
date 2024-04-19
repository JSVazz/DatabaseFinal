import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_player/models/author.dart';

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
}
