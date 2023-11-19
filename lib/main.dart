import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'news_data_model.dart';
import 'news_detail.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

List<News> newsData = [
  News(
    id: 1,
    imageUrl: "assets/images/breakingNews.png",
    description:
        "Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea,Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea",
    title: "Abp News",
  ),
  News(
    id: 2,
    imageUrl: "assets/images/news.png",
    description:
        "Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea,Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea",
    title: "Gujarati News",
  ),
  News(
    id: 3,
    imageUrl: "assets/images/breakingNews.png",
    description:
        "Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea,Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea",
    title: "Hindi News",
  ),
  News(
    id: 4,
    imageUrl: "assets/images/news.png",
    description:
        "Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea,Scientists Discover New Species of Glow-in-the-Dark Jellyfish in Deep Sea",
    title: "punjabi News",
  )
];

List<News> foundNews = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    foundNews = newsData;
    super.initState();
  }

  void runFilter(String enteredKeyboard) {
    setState(() {
      foundNews = newsData
          .where((element) => element.title
              .toLowerCase()
              .contains(enteredKeyboard.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            TextField(
              onChanged: (value) => runFilter(value),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                  suffixIcon: const Icon(Icons.search),
                  hintText: "Search"),
              textAlign: TextAlign.center,
            ),
            foundNews.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: foundNews.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(20.0)),
                          contentPadding: const EdgeInsets.all(5),
                          leading: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(foundNews[index].imageUrl),
                              ),
                            ),
                          ),
                          title: Text(foundNews[index].title,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                icon: Icon(
                                    foundNews[index].isFavorite
                                        // ||
                                        //         FavouritePageState()
                                        //             .favoriteList[index]
                                        //             .isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    foundNews[index].isFavorite =
                                        !foundNews[index].isFavorite;
                                  });
                                },
                              ),
                              IconButton(
                                  onPressed: () {
                                    Share.share(foundNews[index].title);
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.blue,
                                  ))
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewsDetail(
                                    index: index, newsDetails: foundNews)));
                          },
                        ),
                      );
                    })
                : const Text("No data found", style: TextStyle(fontSize: 20)),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavoritePage(),
            ),
          ).then((value) => setState(() {}));
        },
        label: const Text("Favorite News"),
      ),
    );
  }
}
