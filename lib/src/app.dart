import 'package:find_book_pdf/src/presentation/common/app_colors.dart';
import 'package:find_book_pdf/src/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.card,
          primary: AppColors.primary,
          onPrimary: AppColors.primaryForeground,
          outline: AppColors.border,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Baskerville',
            color: AppColors.foreground,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Inter',
            color: AppColors.foreground,
          ),
        ),
      ),
    );
  }
}
