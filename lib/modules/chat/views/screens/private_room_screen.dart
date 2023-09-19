import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/modules/chat/models/chat_message.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/chat/views/widgets/chat_message_bubble.dart';
import 'package:social_x/modules/chat/views/widgets/chat_room_bottom_bar.dart';
//-----------------------------------------------------------------------------

class PrivateChatRoomScreen extends StatelessWidget {
  const PrivateChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.screensHorizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: 7,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (_, i) {
                    return ChatMessageBubble(
                      isRTL: context.isRTL,
                      selfMessage: i % 2 == 0 ? true : false,
                      chatMessage: ChatMessage.fromJson({
                        "sender_id": "1",
                        "sender_name": i % 2 == 0 ? "Ammar" : "Ahmed",
                        "text": i % 2 == 0 ? "Hello" : "Hi",
                        "send_date": 1693525038812,
                      }),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const ChatRoomBottomBar(peerId: "a"),
            ],
          ),
        ),
      ),
    );
  }
}
