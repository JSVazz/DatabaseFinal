import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_player/models/author.dart';
import 'package:audio_player/models/source.dart';
import 'package:audio_player/models/quote.dart';
import 'package:audio_player/models/categorydb.dart';
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
  String colSourceYear = 'year';
  String colSourceType = 'type';

  // Quote Table
  String quoteTable = 'Quote';
  String colQuoteId = 'quoteID';
  String colQuoteSourceId = 'sourceID';
  String colQuoteText = 'text';
  String colQuoteAuthorId = 'authorID';
  String colImageURL2 = 'imageURL';
  String colAudioURL = 'audioURL';

  // Category Table
  String categoryTable = 'Category';
  String colCategoryId = 'categoryID';
  String colCategoryName = 'categoryName';
  String colCategoryDescription = 'description';
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
    await db.execute('''
      CREATE TABLE $sourceTable(
        $colSourceId INTEGER PRIMARY KEY AUTOINCREMENT,  
        $colSourceYear TEXT,
        $colSourceType TEXT)
      ''');

    // create Quote table
    await db.execute('''
      CREATE TABLE $quoteTable (
        $colQuoteId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colQuoteSourceId INTEGER,
        $colQuoteText TEXT,
        $colQuoteAuthorId INTEGER,
        $colImageURL2 TEXT,
        $colAudioURL TEXT,
        FOREIGN KEY ($colQuoteSourceId) REFERENCES $sourceTable($colSourceId),
        FOREIGN KEY ($colQuoteAuthorId) REFERENCES $authorTable($colAuthorId)
      )
    ''');

    // Create Category table
    await db.execute('''
      CREATE TABLE $categoryTable (
        $colCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colCategoryName TEXT,
        $colCategoryDescription TEXT,
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

  static Future<void> insertDataIntoDatabase() async {
    try {
      // Insert authors
      final authorId1 = await DatabaseHelper().createAuthor(
          author(name: "Matsuoka Shuzo", occupation: "Motivational Speaker"));
      final authorId2 = await DatabaseHelper().createAuthor(author(
          name: "Shia LaBeouf", occupation: "American Actor and Performer"));
      final authorId3 = await DatabaseHelper()
          .createAuthor(author(name: "Cicero", occupation: "Roman Statesman"));
      final authorId4 = await DatabaseHelper().createAuthor(
          author(name: "Epictetus", occupation: "Greek Stoic Philosopher"));
      final authorId5 = await DatabaseHelper().createAuthor(
          author(name: "Donald J. Trump", occupation: "Former US President"));
      final authorId6 = await DatabaseHelper().createAuthor(
          author(name: "Joseph R. Biden Jr", occupation: "US President"));
      final authorId7 = await DatabaseHelper().createAuthor(
          author(name: "Michael J. Gough", occupation: "Voice Actor"));
      final authorId8 = await DatabaseHelper().createAuthor(
          author(name: "Ellen McLain", occupation: "Voice Actor"));
      final authorId9 = await DatabaseHelper()
          .createAuthor(author(name: "Pedro Pascal", occupation: "Actor"));
      final authorId10 = await DatabaseHelper()
          .createAuthor(author(name: "Gerard Butler", occupation: "Actor"));
      final authorId11 = await DatabaseHelper().createAuthor(
          author(name: "Matthew Patrick", occupation: "YouTuber"));
      final authorId12 = await DatabaseHelper().createAuthor(author(
          name: "Charles Christopher White Jr. (Cr1TiKaL)",
          occupation: "YouTuber"));

      // Insert sources
      final sourceId1 = await DatabaseHelper().createSource(
          source(year: "2010", type: "Shuzo.co.jp. similar to Youtube"));
      final sourceId2 = await DatabaseHelper().createSource(
          source(year: "2015", type: "@motivashian4248, YouTube"));
      final sourceId3 = await DatabaseHelper().createSource(
          source(year: "106 BC - 43 BC", type: "@quotes_official, YouTube"));
      final sourceId4 = await DatabaseHelper().createSource(
          source(year: "AD 50 - AD 135", type: "@quotes_official, YouTube"));
      final sourceId5 = await DatabaseHelper().createSource(
          source(year: "2016", type: "Rally in Lakeland Florida"));
      final sourceId6 = await DatabaseHelper().createSource(source(
          year: "2020",
          type: "C-Span, Teamsters Presidential Candidate Forum"));
      final sourceId7 = await DatabaseHelper().createSource(
          source(year: "2011", type: "The Elder Scrolls V: Skyrim"));
      final sourceId8 = await DatabaseHelper()
          .createSource(source(year: "2011", type: "Portal 2"));
      final sourceId9 = await DatabaseHelper()
          .createSource(source(year: "1987", type: "The Princess Bride"));
      final sourceId10 = await DatabaseHelper()
          .createSource(source(year: "2006", type: "The 300"));
      final sourceId11 = await DatabaseHelper()
          .createSource(source(year: "2011", type: "@GameTheory"));
      final sourceId12 = await DatabaseHelper()
          .createSource(source(year: "2020", type: "@penguinz0, YouTube"));

      // Insert categories
      final categoryId1 = await DatabaseHelper().createCategory(Category.withoutID(
          categoryName: "Inspirational",
          description:
              "Fuel for the soul, inspiring words to ignite your inner fire",
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s"));
      final categoryId2 = await DatabaseHelper().createCategory(Category.withoutID(
          categoryName: "Philosophical",
          description:
              "Exploring the depths of thought, these quotes ponder the mysteries of existence",
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOcSwmNfT2m6UB6F88ENT14vdR6S6DXEWNew&s"));
      final categoryId3 = await DatabaseHelper().createCategory(Category.withoutID(
          categoryName: "Political",
          description:
              "Insights into power dynamics, societal change, and the pulse of governance",
          imageURL:
              "blahttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkiPffq9GOvPW6FGjZZcpV-Q4vKC5MkY2idA&snk"));
      final categoryId4 = await DatabaseHelper().createCategory(Category.withoutID(
          categoryName: "Videogames",
          description:
              "From pixels to passion, quotes that celebrate the immersive worlds of gaming",
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1Vvqxgu8G57iL_ODpUIRhUXkuH2rpZT6K1Q&s"));
      final categoryId5 = await DatabaseHelper().createCategory(Category.withoutID(
          categoryName: "Youtube",
          description:
              "From viral sensations to profound insights, quotes that define the digital era's cultural landscape",
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStAuG4Pk2gEdMBCCyJ0WR5tzOwxi7gTnYodw&s"));
      final categoryId6 = await DatabaseHelper().createCategory(Category.withoutID(
          categoryName: "Movies",
          description:
              "Capturing the magic of cinema, one iconic line at a time",
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjPlyw4jFcIQ16wAen0OyD4NpAzldtGjXLqA&s"));

      // Insert quotes
      final quoteId1 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId1,
          quoteText:
              "You have to just try! You will surely accomplish your goal! That's why you should never give up!",
          quoteAuthorId: authorId1,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Never_Give_Up.mp3"));
      final quoteId2 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId2,
          quoteText:
              "Do it! Just do it! Don't let your dreams be dreams. Yesterday you said tomorrow, so just do it!",
          quoteAuthorId: authorId2,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Just_Do_It.mp3"));
      final quoteId3 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId3,
          quoteText: "Silence is one of the great arts of conversation.",
          quoteAuthorId: authorId3,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Silence_Great_Arts_Conversation.mp3"));
      final quoteId4 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId4,
          quoteText:
              "Wealth consists not in having great possessions, but in having few wants.",
          quoteAuthorId: authorId4,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Wealth_Few_Wants.mp3"));
      final quoteId5 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId5,
          quoteText:
              "We will no longer surrender this country or its people to the false song of globalism.",
          quoteAuthorId: authorId5,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Globalism_False_Song.mp3"));
      final quoteId6 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId6,
          quoteText:
              "We choose unity over division. We choose science over fiction. We choose truth over facts.",
          quoteAuthorId: authorId6,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Unity_Over_Division.mp3"));
      final quoteId7 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId7,
          quoteText:
              "I used to be an adventurer like you. Then I took an arrow in the knee.",
          quoteAuthorId: authorId7,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Adventurer_Like_You.mp3"));
      final quoteId8 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId8,
          quoteText:
              "This was a triumph. I'm making a note here: HUGE SUCCESS.",
          quoteAuthorId: authorId8,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "This_Was_Triumph.mp3"));
      final quoteId9 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId9,
          quoteText:
              "Hello. My name is Inigo Montoya. You killed my father. Prepare to die.",
          quoteAuthorId: authorId9,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Hello_Inigo_Montoya.mp3"));
      final quoteId10 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId10,
          quoteText: "This is Sparta!",
          quoteAuthorId: authorId10,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "This_Is_Sparta.mp3"));
      final quoteId11 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId11,
          quoteText: "Hello Internet! Welcome to Game Theory!",
          quoteAuthorId: authorId11,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "Hello_Game_Theory.mp3"));
      final quoteId12 = await DatabaseHelper().createQuote(quote(
          quoteSourceId: sourceId12,
          quoteText: "I like that boulder. That is a nice boulder.",
          quoteAuthorId: authorId12,
          imageURL:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW3cpc2w-pPTUnjMQC5vHF3eodBKS06vus0A&s",
          audioURL: "I_Like_That_Boulder.mp3"));
    } catch (e) {
      print('Error inserting data: $e');
    }
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
  // Create a new source and return its ID
  Future<int> createSource(source source) async {
    final db = await database;
    int sourceId = await db.insert(
      'Source',
      source.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return sourceId;
  }

  // Retrieve all sources
  Future<List<source>> getAllSources() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Source');
    return List.generate(maps.length, (i) {
      return source.fromMap(maps[i]);
    });
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
  // Insert a quote into the database
  Future<int> createQuote(quote quote) async {
    Database db = await database;
    int? result;

    await db.transaction((txn) async {
      // Check if the source exists
      var sourceExists = await txn.query(
        'Source',
        where: 'sourceID = ?',
        whereArgs: [quote.quoteSourceId],
      );

      // Check if the author exists
      var authorExists = await txn.query(
        'Author',
        where: 'authorId = ?',
        whereArgs: [quote.quoteAuthorId],
      );

      // If both the source and author exist, insert the quote
      if (sourceExists.isNotEmpty && authorExists.isNotEmpty) {
        result = await txn.insert(quoteTable, quote.toMap());
      } else {
        // Handle the case where either the source or author does not exist
        print('Error: Invalid source or author ID');
        // You can throw an exception or handle this error as appropriate for your application
      }
    });

    return result ?? -1; // Return -1 if the transaction failed
  }

  // Retrieve a quote from the database based on its ID
  Future<quote?> getQuote(int id) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      quoteTable,
      columns: [
        colQuoteId,
        colQuoteSourceId,
        colQuoteText,
        colQuoteAuthorId,
        colImageURL,
        colAudioURL,
      ],
      where: '$colQuoteId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return quote.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Retrieve all quotes from the database
  Future<List<quote>> getAllQuotes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(quoteTable);
    List<quote> quotes = [];
    for (Map<String, dynamic> map in maps) {
      quotes.add(quote.fromMap(map));
    }
    return quotes;
  }

  // Update a quote in the database
  Future<int> updateQuote(quote quote) async {
    Database db = await database;
    int result = await db.update(
      quoteTable,
      quote.toMap(),
      where: '$colQuoteId = ?',
      whereArgs: [quote.quoteId],
    );
    return result;
  }

  // Delete a quote from the database
  Future<int> deleteQuote(int id) async {
    Database db = await database;
    int result = await db.delete(
      quoteTable,
      where: '$colQuoteId = ?',
      whereArgs: [id],
    );
    return result;
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
    final List<Map<String, dynamic>> maps = await db.query(
      categoryTable,
      where: '$colCategoryId = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return Category.fromMap(maps.first);
  }

  // Method to update an existing category in the database
  Future<int> updateCategory(Category category) async {
    final db = await database;
    return db.update(
      categoryTable,
      category.toMap(),
      where: '$colCategoryId = ?',
      whereArgs: [category.categoryID],
    );
  }

  // Method to delete a category from the database
  Future<int> deleteCategory(int id) async {
    final db = await database;
    return db.delete(
      categoryTable,
      where: '$colCategoryId = ?',
      whereArgs: [id],
    );
  }

  //CRUD operations for User table
  // Create a new user
  Future<void> createUser(user user) async {
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
