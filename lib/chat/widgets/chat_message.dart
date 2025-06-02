import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/shared/api/message.dart';

class ChatMessage extends StatelessWidget {
  final MessageModel message;

  const ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == Role.USER;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        // margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        margin: EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            fontSize: 16,
            color: isUser ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
