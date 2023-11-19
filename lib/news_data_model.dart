class News {
  int id;
  String imageUrl;
  String description;
  String title;
  bool isFavorite = false;

  News({
    required this.id,
    required this.imageUrl,
    required this.description,
    required this.title,
  });
}
