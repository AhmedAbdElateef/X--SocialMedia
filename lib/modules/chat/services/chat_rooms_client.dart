import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRoomsClient {
  final _loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get _chatRooms {
    return FirebaseFirestore.instance.collection("chat_rooms");
  }

  Stream<QuerySnapshot> get chatRoomsStream => _chatRooms
      .where("participants", arrayContains: _loggedInUserId)
      .orderBy("last_message.send_date", descending: true)
      .snapshots();
}
