class NewsArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String content;
  final String url;
  bool isBookmarked;

  NewsArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.url,
    this.isBookmarked = false,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? '',
      content: json['content'] ?? 'No Content',
      url: json['url'] ?? '',
    );
  }
}

