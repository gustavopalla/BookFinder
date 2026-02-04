import 'package:find_book_pdf/src/presentation/common/app_colors.dart';
import 'package:find_book_pdf/src/presentation/common/components/typing_indicator.dart';
import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _appearanceController;

  @override
  void initState() {
    super.initState();
    _appearanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Buscando PDFs',
          style: TextStyle(fontSize: 12, color: AppColors.foreground),
        ),
        const SizedBox(width: 8),
        _buildDot(0.0),
        _buildDot(0.2),
        _buildDot(0.4),
      ],
    );
  }

  Widget _buildDot(double delay) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _appearanceController,
        curve: Interval(delay, 1.0, curve: Curves.easeInOut),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.foreground,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _appearanceController.dispose();
    super.dispose();
  }
}
