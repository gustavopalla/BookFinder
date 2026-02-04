import 'package:find_book_pdf/src/data/models/book_message_model.dart';
import 'package:find_book_pdf/src/presentation/common/app_colors.dart';
import 'package:find_book_pdf/src/presentation/common/components/chat_bubble.dart';
import 'package:find_book_pdf/src/presentation/common/components/chat_input.dart';
import 'package:find_book_pdf/src/presentation/common/components/suggestion_cards.dart';
import 'package:find_book_pdf/src/services/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 100,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(38, 217, 119, 6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BookFinder',
                    style: GoogleFonts.libreBaskerville(
                      color: AppColors.foreground,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Encontre livros em PDF',
                    style: TextStyle(
                      color: const Color.fromARGB(185, 61, 54, 47),
                      fontSize: 12,
                      fontFamily: 'Baskerville',
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: AppColors.border, height: 1.0),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, _) {
                  if (chatProvider.messages.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(47, 217, 119, 6),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Olá :)',
                              style: GoogleFonts.libreBaskerville(
                                color: AppColors.foreground,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 04,
                                vertical: 12,
                              ),
                              child: Text(
                                'Digite o nome de um livro que você quer baixar em PDF e eu vou buscar links para você.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.foreground,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const SuggestionCards(),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: chatProvider.messages.length,
                    itemBuilder: (context, index) {
                      if (index == chatProvider.messages.length) {
                        return const ChatBubble(
                          message: BookMessage(
                            text: '',
                            sender: MessageSender.bot,
                            isTyping: true,
                          ),
                        );
                      }
                      final msg = chatProvider.messages[index];
                      return ChatBubble(message: msg);
                    },
                  );
                },
              ),
            ),
            const ChatInput(),
          ],
        ),
      ),
    );
  }
}
