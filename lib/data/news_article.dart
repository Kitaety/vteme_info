class NewsArticle {
  final String title;
  final String category;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String date;
  bool isFavorite;

  NewsArticle({
    this.title,
    this.category,
    this.description,
    this.urlToImage,
    this.url,
    this.publishedAt,
    this.date,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'description': description,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'url': url,
        'date': date,
        'isFavorite': isFavorite
      };

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      category: json['category'],
      description: json['description'],
      urlToImage: json['urlToImage'] != null ? json['urlToImage'] : "",
      publishedAt: json['publishedAt'],
      url: json['url'] != null ? json['url'] : "",
      date: json['date'],
      isFavorite: json['isFavorite'],
    );
  }
}
