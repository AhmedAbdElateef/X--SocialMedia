class Notification {
  bool? read;

  String? postId;
  String? event;
  String? receiverId;
  String? senderId;
  String? receiverName;
  String? senderName;

  Notification.fromJson(Map<String, dynamic> data) {
    read = data["read"];
    event = data["event"];
    postId = data["post_id"];
    senderId = data["sender_id"];
    senderName = data["sender_name"];
    receiverId = data["receiver_id"];
    receiverName = data["receiver_name"];
  }

  Map<String, dynamic> toJson() {
    return {
      "read": read,
      "event": event,
      "post_id": postId,
      "sender_id": senderId,
      "sender_name": senderName,
      "receiver_id": receiverId,
      "receiver_name": receiverName,
    };
  }
}
