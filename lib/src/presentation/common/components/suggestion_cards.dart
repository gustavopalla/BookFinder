import 'package:find_book_pdf/src/app.dart';
import 'package:find_book_pdf/src/presentation/common/app_colors.dart';
import 'package:find_book_pdf/src/services/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuggestionCards extends StatelessWidget {
  const SuggestionCards({super.key});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'O Pequeno Príncipe',
      'Dom Casmurro',
      'Hábitos Atômicos',
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: suggestions.map((book) {
        return ActionChip(
          label: Text(
            book,
            style: TextStyle(color: AppColors.primary, fontSize: 13),
          ),
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.transparent),
          ),
          onPressed: () {
            context.read<ChatProvider>().sendMessage(book);
          },
        );
      }).toList(),
    );
  }
}
