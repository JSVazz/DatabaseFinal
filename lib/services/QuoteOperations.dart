import 'package:audio_player/models/quote.dart';
import 'package:audio_player/utils/databasehelper.dart';

class QuoteOperations {
  static final _dbHelper = DatabaseHelper();

  static Future<List<quote>> getAllQuotes() async {
    List<quote> quotes = [];
    List<quote> dbQuotes = await _dbHelper.getAllQuotes();
    for (var dbQuote in dbQuotes) {
      quote newQuote = quote(
        quoteSourceId: dbQuote.quoteSourceId,
        quoteText: dbQuote.quoteText,
        quoteAuthorId: dbQuote.quoteAuthorId,
        imageURL: dbQuote.imageURL,
        audioURL: dbQuote.audioURL,
      );
      quotes.add(newQuote);
    }
    return quotes;
  }
}
