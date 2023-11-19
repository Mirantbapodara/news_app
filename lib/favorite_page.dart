import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'news_data_model.dart';
import 'news_detail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<StatefulWidget> createState() => FavouritePageState();
}

class FavouritePageState extends State<FavoritePage> {
  List<News> favoriteList = [];

  @override
  void initState() {
    super.initState();
    sortFav();
  }

  void sortFav() {
    for (var value in newsData) {
      if (value.isFavorite == true) {
        favoriteList.add(value);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite News"),
          centerTitle: true,
        ),
        body: favoriteList.isEmpty
            ? const Center(
                child: Text(
                  "There is no data",
                  style: TextStyle(color: Colors.black),
                ),
              )
            : ListView.builder(
                itemCount: favoriteList.length,
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
                            image: AssetImage(favoriteList[index].imageUrl),
                          ))),
                      title: Text(favoriteList[index].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              for (int i = 0; i < foundNews.length; i++) {
                                if (favoriteList[index].id == foundNews[i].id) {
                                  foundNews[i].isFavorite = false;
                                }
                              }
                              favoriteList.removeAt(index);
                            });
                          }),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsDetail(
                                index: index, newsDetails: favoriteList)));
                      },
                    ),
                  );
                }));
  }
}
