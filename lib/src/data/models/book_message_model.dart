enum MessageSender { user, bot }

class BookMessage {
  final String text;
  final MessageSender sender;
  final List<BookResource>? resources;
  final bool isTyping;

  const BookMessage({
    required this.text,
    required this.sender,
    this.resources,
    this.isTyping = false,
  });
}

class BookResource {
  final String title;
  final String url;

  const BookResource({required this.title, required this.url});
}
