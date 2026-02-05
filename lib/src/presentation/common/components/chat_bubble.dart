import 'package:find_book_pdf/src/data/models/book_message_model.dart';
import 'package:find_book_pdf/src/presentation/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBubble extends StatelessWidget {
  final BookMessage message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message.sender == MessageSender.user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) _buildBotAvatar(),
          const SizedBox(width: 8),

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? AppColors.accent : Colors.white,
                border: isUser ? null : Border.all(color: AppColors.border),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 0), // Ponta do Bot
                  bottomRight: Radius.circular(isUser ? 0 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.border.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildMessageContent(message, isUser),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildMessageContent(BookMessage message, bool isUser) {
  if (message.isTyping) {
    return const TypingIndicator();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!isUser)
        const Text(
          'BookFinder',
          style: TextStyle(
            color: AppColors.primaryForeground,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),

      Text(
        message.text,
        style: TextStyle(
          color: isUser
              ? AppColors.primaryForeground
              : AppColors.secondaryForeground,
        ),
      ),
      if (message.resources != null) ...[
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(height: 1),
        ),
        ...message.resources!.map((res) => _buildDownloadButton(res)),
      ],
    ],
  );
}

Widget _buildBotAvatar() {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.secondary,
      borderRadius: BorderRadius.circular(16),
    ),
    child: const Icon(Icons.book, color: AppColors.secondaryForeground),
  );
}

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Typing...',
        style: TextStyle(color: AppColors.secondaryForeground),
      ),
    );
  }
}

Widget _buildDownloadButton(BookResource res) {
  final bool isEpub =
      res.url.toLowerCase().contains('.epub') ||
      res.title.toLowerCase().contains('epub');

  debugPrint('Link: ${res.url} | IsEpub: $isEpub');

  return TextButton.icon(
    onPressed: () async {
      final Uri url = Uri.parse(res.url);
      try {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } catch (e) {
        print('Error launching URL: $e');
      }
    },
    icon: Icon(
      isEpub ? Icons.auto_stories_rounded : Icons.picture_as_pdf_rounded,
      size: 18,
      color: isEpub ? Colors.green[700] : Colors.red[700],
    ),
    label: Text(
      '${res.title} ${isEpub ? "(ePub)" : "(PDF)"}',
      style: const TextStyle(fontSize: 13),
    ),
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.centerLeft,
    ),
  );
}
