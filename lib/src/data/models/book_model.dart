class BookModel {
  final String title;
  final String link;
  final String displayLink;

  BookModel({
    required this.title,
    required this.link,
    required this.displayLink,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] ?? 'Sem título',
      link: json['link'] ?? 'Sem link',
      displayLink: json['displayLink'] ?? 'Sem link',
    );
  }
}
