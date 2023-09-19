import 'package:social_x/modules/chat/models/chat_message.dart';
//--------------------------------------------------------------

class ChatRoom {
  Map? participantsIds;
  Map? participantsStatus;

  ChatMessage? lastMessage;

  ChatRoom.fromJson(Map data) {
    participantsIds = data["participants_ids"];
    participantsStatus = data["participants_status"];
    lastMessage = ChatMessage.fromJson(data["last_message"]);
  }
}
