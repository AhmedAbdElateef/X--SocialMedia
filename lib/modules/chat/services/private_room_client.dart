import 'package:cloud_firestore/cloud_firestore.dart';

class PrivateRoomClient {
  final String chatRoomId;

  PrivateRoomClient(this.chatRoomId);

  CollectionReference get _chatRooms {
    return FirebaseFirestore.instance.collection("chat_rooms");
  }

  Query get messageQuery {
    return _chatRooms
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("send_date", descending: false);
  }
}
