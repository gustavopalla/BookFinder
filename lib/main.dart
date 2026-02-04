import 'package:find_book_pdf/src/app.dart';
import 'package:find_book_pdf/src/services/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: const App(),
    ),
  );
}
