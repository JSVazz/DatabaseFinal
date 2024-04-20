import 'package:audio_player/models/quote.dart';
import 'package:audio_player/models/categorydb.dart';
import 'package:audio_player/services/CategoryOperations.dart';
import 'package:audio_player/services/quoteOperations.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Function _miniPlayer;
  const Home(this._miniPlayer, {super.key});

  Widget createCategory(Category category) {
    return Container(
      color: Colors.blueGrey.shade300,
      child: Row(
        children: [
          Image.network(
            category.imageURL,
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          ),
          const Padding(padding: EdgeInsets.only(left: 8.0)),
          Text(
            category.categoryName,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Future<List<Widget>> createListOfCategories() async {
    List<Category> categoryList = await CategoryOperations.getCategories();
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();

    return categories;
  }

  Widget createQuote(quote quote) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: InkWell(
              onTap: () {
                // Handle quote tap
              },
              child: Image.network(
                quote.imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            quote.quoteText,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget createQuoteList(String label) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            FutureBuilder<List<quote>>(
              future: QuoteOperations.getAllQuotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Widget> quoteWidgets = snapshot.data!
                      .map((quote) => createQuote(quote))
                      .toList();
                  return SizedBox(
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: quoteWidgets,
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 10.0), child: Icon(Icons.settings))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.blueGrey.shade300,
          Colors.black,
          Colors.black,
          Colors.black,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          children: [
            createAppBar("howdy"),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<List<Widget>>(
              future: createListOfCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    padding: const EdgeInsets.all(10),
                    height: 285,
                    child: GridView.count(
                      childAspectRatio: 5 / 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: snapshot.data!,
                    ),
                  );
                }
              },
            ),
            createQuoteList('Quotes'),
            // Additional methods for displaying other types of data if needed
          ],
        ),
      )),
    );
  }
}
