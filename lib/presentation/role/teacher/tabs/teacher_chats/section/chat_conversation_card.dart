import 'package:edura/core/extensions/date_ex.dart';
import 'package:edura/core/model/chat_conversation_model.dart';
import 'package:edura/core/resources/colors/color_manger.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_text.dart';

class ChatConversationCard extends StatelessWidget {
  const ChatConversationCard({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  final ChatConversationModel conversation;
  final VoidCallback onTap;

  String get _initials {
    final parts = conversation.studentName.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return parts.isNotEmpty ? parts[0][0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unreadCount > 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        color: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: hasUnread
                ? ColorManager.primary
                : ColorManager.black.withValues(alpha: 0.1),
            width: hasUnread ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: ColorManager.primary.withValues(alpha: 0.12),
                    child: CustomText(
                      text: _initials,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (conversation.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorManager.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: conversation.studentName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorManager.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          text: conversation.lastMessageTime.formatDate,
                          style: TextStyle(
                            color: hasUnread
                                ? ColorManager.primary
                                : ColorManager.black.withValues(alpha: 0.5),
                            fontSize: 12,
                            fontWeight: hasUnread ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: conversation.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hasUnread
                            ? ColorManager.black.withValues(alpha: 0.8)
                            : ColorManager.black.withValues(alpha: 0.5),
                        fontSize: 13,
                        fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasUnread) ...[
                const SizedBox(width: 8),
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: CustomText(
                    text: '${conversation.unreadCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}