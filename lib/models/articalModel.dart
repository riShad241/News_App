class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime publishedAt;
  final String sourceName;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.publishedAt,
    required this.sourceName,
  });
}