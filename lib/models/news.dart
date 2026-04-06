class NewsModel {
  final SourceModel? source;
  final String? author,
      title,
      description,
      url,
      urlImage,
      date,
      content,
      category;

  const NewsModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlImage,
    this.date,
    this.content,
    this.category,
  });

  NewsModel.fromJson(Map<String, dynamic> json, String cate)
    : source = SourceModel.fromJson(json['source']),
      author = json['author'],
      title = json['title'],
      description = json['description'],
      url = json['url'],
      urlImage = json['urlToImage'],
      date = json['publishedAt'],
      content = json['content'],
      category = cate;

  NewsModel.fromDb(Map<String, dynamic> json)
    : source = SourceModel(id: json['sourceId'], name: json['sourceName']),
      author = json['author'],
      title = json['title'],
      description = json['description'],
      url = json['url'],
      urlImage = json['urlImage'],
      date = json['date'],
      content = json['content'],
      category = json['category'];

  Map<String, dynamic> toJson() => {
    'sourceId': source?.id,
    'sourceName': source?.name,
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlImage': urlImage,
    'date': date,
    'content': content,
    'category': category,
  };
}

class SourceModel {
  final String? id, name;

  const SourceModel({this.id, this.name});

  SourceModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'];
}
