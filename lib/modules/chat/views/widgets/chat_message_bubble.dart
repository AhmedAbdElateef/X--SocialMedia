import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/helpers/functions/time_ago_util.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/chat/models/chat_message.dart';
import 'package:social_x/modules/chat/views/widgets/message_widgets/text_message_widget.dart';
import 'package:social_x/modules/chat/views/widgets/message_widgets/image_message_widget.dart';
//---------------------------------------------------------------------------------------------

class ChatMessageBubble extends StatelessWidget {
  final bool isRTL;
  final bool selfMessage;

  final ChatMessage chatMessage;

  const ChatMessageBubble({
    super.key,
    required this.isRTL,
    required this.selfMessage,
    required this.chatMessage,
  });

  TextDirection get textDirection {
    if (isRTL) {
      return selfMessage ? TextDirection.rtl : TextDirection.ltr;
    } else {
      return selfMessage ? TextDirection.ltr : TextDirection.rtl;
    }
  }

  Widget get messageWidget {
    if (chatMessage.imageUrl != null) {
      return ImageMessageWidget(
        chatMessage.imageUrl.toString(),
        chatMessage.senderName.toString(),
      );
    } else if (chatMessage.voiceUrl != null) {
      return Container();
    } else {
      return TextMessageWidget(
        selfMessage: selfMessage,
        text: chatMessage.text.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        textDirection: textDirection,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(child: messageWidget),
          const SizedBox(width: 8.0),
          Text(
            TimeAgoUtil(shortFormat: true).formatTime(
              DateTime.parse("2020-01-31"),
              context.langCode,
            ),
            style: const TextStyle(
              height: 1.0,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
