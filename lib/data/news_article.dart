class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String content;
  bool isFavorite = false;

  NewsArticle({
    this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.publishedAt,
    this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'] != null ?json['urlToImage'] : "" ,
      publishedAt: json['publishedAt'],
      url: json['url'] != null? json['url'] : "",
      content: json['content'],
    );
  }
}
