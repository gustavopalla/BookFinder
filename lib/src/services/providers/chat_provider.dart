import 'package:find_book_pdf/src/data/models/book_message_model.dart';
import 'package:find_book_pdf/src/data/models/book_model.dart';
import 'package:find_book_pdf/src/services/search_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final List<BookMessage> _messages = [];
  bool _isLoading = false;
  final SearchService _searchService = SearchService();

  List<BookMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(BookMessage(text: text, sender: MessageSender.user));
    _isLoading = true;
    notifyListeners();

    try {
      final results = await _searchService.fetchBooks(text);

      if (results.isEmpty) {
        _messages.add(
          BookMessage(
            text: 'Poxa, não encontrei nenhum PDF para "$text".',
            sender: MessageSender.bot,
          ),
        );
      } else {
        // Convert BookModel list to BookResource list
        final resources = results.map((book) {
          return BookResource(title: book.title, url: book.link);
        }).toList();

        _messages.add(
          BookMessage(
            text: 'Encontrei esses PDFs para "$text":',
            sender: MessageSender.bot,
            resources: resources,
          ),
        );
      }
    } catch (e) {
      _messages.add(
        BookMessage(
          text: 'Ops, tive um erro ao conectar no servidor.',
          sender: MessageSender.bot,
        ),
      );
    }
    _isLoading = false;
    notifyListeners();
  }
}
