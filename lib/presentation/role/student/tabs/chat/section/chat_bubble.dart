import 'package:edura/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/model/chat_message_model.dart';
import '../../../../../../core/resources/colors/color_manger.dart';


class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessageModel message;

  bool get _isMe => message.sender == MessageSender.student;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: _isMe
              ? ColorManager.primary
              : ColorManager.gray.withValues(alpha: 0.12),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(_isMe ? 14 : 2),
            bottomRight: Radius.circular(_isMe ? 2 : 14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: message.text,
              style: TextStyle(
                color: _isMe ? Colors.white : ColorManager.black,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: DateFormat('h:mm a').format(message.time),
                  style: TextStyle(
                    color: _isMe
                        ? Colors.white.withValues(alpha: 0.7)
                        : ColorManager.black.withValues(alpha: 0.5),
                    fontSize: 10,
                  ),
                ),
                if (_isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message.isRead ? Icons.done_all : Icons.done,
                    size: 14,
                    color: message.isRead
                        ? Colors.lightBlueAccent
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}