class APIModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;
  APIModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
    required this.publishedAt,
  });

  factory APIModel.fromjson(Map<String, dynamic> map) {
    return APIModel(
        author: map['author'].toString(),
        title: map['title'],
        description: map['description'].toString(),
        url: map['url'],
        urlToImage: map['urlToImage'].toString(),
        content: map['content'].toString(),
        publishedAt: map['publishedAt']);
  }
}
