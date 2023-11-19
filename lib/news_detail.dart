import 'package:flutter/material.dart';
import 'main.dart';

class NewsDetail extends StatefulWidget {
  final List newsDetails;
  final int index;

  const NewsDetail({Key? key, required this.index, required this.newsDetails})
      : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News in Details",
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Text(
          widget.newsDetails[widget.index].title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Image.asset(widget.newsDetails[widget.index].imageUrl),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(widget.newsDetails[widget.index].description,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 10),
        IconButton(
          onPressed: () {
            setState(() {
              foundNews[widget.index].isFavorite =
                  !foundNews[widget.index].isFavorite;
            });
          },
          icon: Icon(
              foundNews[widget.index].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red),
        ),
      ]),
    );
  }
}
